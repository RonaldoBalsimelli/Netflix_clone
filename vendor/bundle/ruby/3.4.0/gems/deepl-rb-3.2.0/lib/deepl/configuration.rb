# Copyright 2018 Daniel Herzog
# Use of this source code is governed by an MIT
# license that can be found in the LICENSE.md file.
# frozen_string_literal: true

module DeepL
  class Configuration
    ATTRIBUTES = %i[auth_key host logger max_doc_status_queries max_network_retries user_agent
                    version].freeze

    attr_accessor(*ATTRIBUTES)

    DEEPL_SERVER_URL = 'https://api.deepl.com'
    DEEPL_SERVER_URL_FREE = 'https://api-free.deepl.com'
    private_constant :DEEPL_SERVER_URL, :DEEPL_SERVER_URL_FREE

    def initialize(data = {}, app_info_name = nil, app_info_version = nil, send_platform_info = true) # rubocop:disable all
      data.each { |key, value| send("#{key}=", value) }
      @auth_key ||= ENV.fetch('DEEPL_AUTH_KEY', nil)
      @host ||= ENV.fetch('DEEPL_SERVER_URL', nil)
      @host ||= if self.class.free_account_auth_key?(@auth_key)
                  DEEPL_SERVER_URL_FREE
                else
                  DEEPL_SERVER_URL
                end
      @version ||= 'v2'
      @user_agent ||= construct_user_agent(send_platform_info, app_info_name, app_info_version)
      @max_network_retries ||= 5
      @logger ||= nil
    end

    def validate!
      raise Exceptions::Error, 'auth_key not provided' if auth_key.nil? || auth_key.empty?
    end

    def attributes
      ATTRIBUTES.to_h { |attr| [attr, send(attr)] }
    end

    def ==(other)
      attributes == other.attributes
    end

    def self.free_account_auth_key?(key)
      key&.end_with?(':fx')
    end

    def construct_user_agent(send_platform_info, app_info_name, app_info_version)
      library_info_str = 'deepl-ruby/3.0.2'
      if send_platform_info
        library_info_str += " (#{RbConfig::CONFIG['host_os']}) ruby/#{RUBY_VERSION}"
      end
      if app_info_name && app_info_version
        library_info_str += " #{app_info_name}/#{app_info_version}"
      end
      library_info_str
    end
  end
end
