# Copyright 2025 DeepL SE (https://www.deepl.com)
# Use of this source code is governed by an MIT
# license that can be found in the LICENSE.md file.
# frozen_string_literal: true

module DeepL
  module Constants
    class BaseConstant
      def self.options
        constants.map { |const| const_get(const) }
      end

      def self.valid?(value)
        options.include?(value)
      end
    end
  end
end
