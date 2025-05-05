# Copyright 2022 Daniel Herzog
# Use of this source code is governed by an MIT
# license that can be found in the LICENSE.md file.
# frozen_string_literal: true

module DeepL
  module Requests
    module Glossary
      class LanguagePairs < Base
        def initialize(api, options = {})
          super
        end

        def request
          build_language_pair_list(*execute_request_with_retries(get_request))
        end

        def to_s
          "GET #{uri.request_uri}"
        end

        private

        def build_language_pair_list(request, response)
          data = JSON.parse(response.body)
          data['supported_languages'].map do |language_pair|
            Resources::LanguagePair.new(language_pair['source_lang'], language_pair['target_lang'],
                                        request, response)
          end
        end

        def path
          'glossary-language-pairs'
        end
      end
    end
  end
end
