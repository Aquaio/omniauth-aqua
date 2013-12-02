require 'omniauth-oauth2'
require 'multi_json'

module OmniAuth
  module Strategies

    class AquaProvider < OmniAuth::Strategies::OAuth2
      option :name, 'aqua_provider'

      option :client_options, { 
                                :site => 'http://api.aqua.io',
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

    # class AquaMember < OmniAuth::Strategies::OAuth2
    #   option :name, 'aqua_member'

    #   option :client_options, { 
    #                             :site => 'http://api.aqua.io',
    #                             :authorize_path => 'members/oauth/authenticate',
    #                             :request_token_path => 'members/oauth/token'
    #                           }

    #   uid { access_token.params[:user_id] }

    #   info do
    #     {
    #       :first_name   => raw_info['first_name'],
    #       :last_name    => raw_info['last_name'],
    #       :user_type    => raw_info['user_type']
    #     }
    #   end

    #   extra do
    #     { :raw_info => raw_info }
    #   end

    #   def raw_info
    #     @raw_info ||= MultiJson.decode(access_token.get('beta/members/me.json').body)
    #   rescue ::Errno::ETIMEDOUT
    #     raise ::Timeout::Error
    #   end

    # end

  end
end
