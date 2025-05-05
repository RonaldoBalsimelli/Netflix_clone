# Copyright 2025 DeepL SE (https://www.deepl.com)
# Use of this source code is governed by an MIT
# license that can be found in the LICENSE.md file.
# frozen_string_literal: true

require 'spec_helper'

describe 'DeepL::Constants' do
  describe DeepL::Constants::Tone do
    subject(:tone) { described_class }

    it 'includes all expected tone values' do # rubocop:disable RSpec/ExampleLength
      expect(tone.options).to contain_exactly(
        'confident',
        'default',
        'diplomatic',
        'enthusiastic',
        'friendly',
        'prefer_confident',
        'prefer_diplomatic',
        'prefer_enthusiastic',
        'prefer_friendly'
      )
    end

    it 'validates correct tone values' do
      expect(tone.valid?('enthusiastic')).to be true
      expect(tone.valid?('friendly')).to be true
      expect(tone.valid?('confident')).to be true
      expect(tone.valid?('diplomatic')).to be true
      expect(tone.valid?('default')).to be true
    end

    it 'invalidates incorrect tone values' do
      expect(tone.valid?('angry')).to be false
      expect(tone.valid?('')).to be false
      expect(tone.valid?(nil)).to be false
    end
  end

  describe DeepL::Constants::WritingStyle do
    subject(:writing_style) { described_class }

    it 'includes all expected writing style values' do # rubocop:disable RSpec/ExampleLength
      expect(writing_style.options).to contain_exactly(
        'default',
        'simple',
        'business',
        'academic',
        'casual',
        'prefer_academic',
        'prefer_business',
        'prefer_casual',
        'prefer_simple'
      )
    end

    it 'validates correct writing style values' do
      expect(writing_style.valid?('simple')).to be true
      expect(writing_style.valid?('business')).to be true
      expect(writing_style.valid?('academic')).to be true
      expect(writing_style.valid?('casual')).to be true
      expect(writing_style.valid?('default')).to be true
    end

    it 'invalidates incorrect writing style values' do
      expect(writing_style.valid?('wordy')).to be false
      expect(writing_style.valid?('')).to be false
      expect(writing_style.valid?(nil)).to be false
    end
  end

  describe DeepL::Constants::TagHandling do
    subject(:tag_handling) { described_class }

    it 'includes all expected tag handling values' do
      expect(tag_handling.options).to contain_exactly('xml', 'html')
    end

    it 'validates correct tag handling values' do
      expect(tag_handling.valid?('xml')).to be true
      expect(tag_handling.valid?('html')).to be true
    end

    it 'invalidates incorrect tag handling values' do
      expect(tag_handling.valid?('json')).to be false
      expect(tag_handling.valid?('')).to be false
      expect(tag_handling.valid?(nil)).to be false
    end
  end

  describe DeepL::Constants::SplitSentences do
    subject(:split_sentences) { described_class }

    it 'includes all expected split sentences values' do
      expect(split_sentences.options).to contain_exactly('0', '1', 'nonewlines')
    end

    it 'validates correct split sentences values' do
      expect(split_sentences.valid?('0')).to be true
      expect(split_sentences.valid?('1')).to be true
      expect(split_sentences.valid?('nonewlines')).to be true
    end

    it 'invalidates incorrect split sentences values' do
      expect(split_sentences.valid?('2')).to be false
      expect(split_sentences.valid?('')).to be false
      expect(split_sentences.valid?(nil)).to be false
    end
  end

  describe DeepL::Constants::ModelType do
    subject(:model_type) { described_class }

    it 'includes all expected model type values' do
      expect(model_type.options).to contain_exactly(
        'quality_optimized',
        'prefer_quality_optimized',
        'latency_optimized'
      )
    end

    it 'validates correct model type values' do
      expect(model_type.valid?('quality_optimized')).to be true
      expect(model_type.valid?('prefer_quality_optimized')).to be true
      expect(model_type.valid?('latency_optimized')).to be true
    end

    it 'invalidates incorrect model type values' do
      expect(model_type.valid?('speed_optimized')).to be false
      expect(model_type.valid?('')).to be false
      expect(model_type.valid?(nil)).to be false
    end
  end

  describe DeepL::Constants::Formality do
    subject(:formality) { described_class }

    it 'includes all expected formality values' do
      expect(formality.options).to contain_exactly('default', 'more', 'less', 'prefer_more',
                                                   'prefer_less')
    end

    it 'validates correct formality values' do
      expect(formality.valid?('default')).to be true
      expect(formality.valid?('more')).to be true
      expect(formality.valid?('less')).to be true
      expect(formality.valid?('prefer_more')).to be true
      expect(formality.valid?('prefer_less')).to be true
    end

    it 'invalidates incorrect formality values' do
      expect(formality.valid?('neutral')).to be false
      expect(formality.valid?('')).to be false
      expect(formality.valid?(nil)).to be false
    end
  end
end
