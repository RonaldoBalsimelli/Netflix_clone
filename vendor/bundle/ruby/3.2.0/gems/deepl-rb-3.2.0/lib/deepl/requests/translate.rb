# Copyright 2018 Daniel Herzog
# Use of this source code is governed by an MIT
# license that can be found in the LICENSE.md file.
# frozen_string_literal: true

module DeepL
  module Requests
    class Translate < Base
      STRING_TO_BOOLEAN_MAP = { '1' => true, '0' => false }.freeze
      BOOLEAN_TO_STRING_MAP = { true => '1', false => '0' }.freeze
      STRING_TO_BOOLEAN_CONVERSION = ->(value) { STRING_TO_BOOLEAN_MAP[value] }
      BOOLEAN_TO_STRING_CONVERSION = ->(value) { BOOLEAN_TO_STRING_MAP[value] }
      STRING_TO_ARRAY_CONVERSION = lambda { |value|
        if value.nil?
          nil
        else
          (value.is_a?(Array) ? value : value.split(','))
        end
      }.freeze
      OPTIONS_CONVERSIONS = {
        split_sentences: BOOLEAN_TO_STRING_CONVERSION,
        preserve_formatting: STRING_TO_BOOLEAN_CONVERSION,
        outline_detection: STRING_TO_BOOLEAN_CONVERSION,
        splitting_tags: STRING_TO_ARRAY_CONVERSION,
        non_splitting_tags: STRING_TO_ARRAY_CONVERSION,
        ignore_tags: STRING_TO_ARRAY_CONVERSION
      }.freeze

      attr_reader :text, :source_lang, :target_lang, :ignore_tags, :splitting_tags,
                  :non_splitting_tags, :model_type

      def initialize(api, text, source_lang, target_lang, options = {})
        super(api, options)
        @text = text
        @source_lang = source_lang
        @target_lang = target_lang

        tweak_parameters!
      end

      def request
        text_arrayified = text.is_a?(Array) ? text : [text]
        payload = { text: text_arrayified, source_lang: source_lang, target_lang: target_lang }
        build_texts(*execute_request_with_retries(post_request(payload)))
      end

      def details
        "HTTP Headers: #{headers}\nPayload #{{ text: text, source_lang: source_lang,
                                               target_lang: target_lang }}"
      end

      def to_s
        "POST #{uri.request_uri}"
      end

      private

      def tweak_parameters!
        OPTIONS_CONVERSIONS.each do |param, converter|
          next unless option?(param) && !converter[option(param)].nil?

          set_option(param, converter[option(param)])
        end
      end

      def build_texts(request, response)
        data = JSON.parse(response.body)

        texts = data['translations'].map do |translation|
          Resources::Text.new(translation['text'], translation['detected_source_language'],
                              translation['model_type_used'], request, response)
        end

        texts.size == 1 ? texts.first : texts
      end

      def path
        'translate'
      end
    end
  end
end
