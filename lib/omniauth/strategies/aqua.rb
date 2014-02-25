require 'omniauth-oauth2'
require 'multi_json'

module OmniAuth
  module Strategies

    class AquaProvider < OmniAuth::Strategies::OAuth2
      option :name, 'aqua_provider'

      option :client_options, { 
                                :site => 'https://api.aqua.io',
                                :authorize_path => 'providers/oauth/authenticate',
                                :request_token_path => 'providers/oauth/token'
                              }

      uid { raw_info['provider_uid'] }

      info do
        {
          :provider_uid => raw_info['provider_uid'],
          :first_name   => raw_info['first_name'],
          :middle_name  => raw_info['middle_name'],
          :last_name    => raw_info['last_name'],
          :user_type    => raw_info['user_type'],
          :specialty    => raw_info['specialty'],
          :organization => raw_info['organization'],
          :email        => raw_info['email']
        }
      end

      extra do
        { :raw_info => raw_info }
      end

      def raw_info
        @raw_info ||= MultiJson.decode(access_token.get('beta/providers/me.json').body)
      rescue ::Errno::ETIMEDOUT
        raise ::Timeout::Error
      end

    end

    class AquaProviderSandbox < AquaProvider
      option :name, 'aqua_provider_sandbox'

      option :client_options, { 
                                :site => 'http://sandbox.aqua.io',
                                :authorize_path => 'providers/oauth/authenticate',
                                :request_token_path => 'providers/oauth/token'
                              }

    end

  end
end
