require 'omniauth-oauth2'

module Omniauth
  module Strategies
    class Telepass < OmniAuth::Strategies::OAuth2
      option :client_options, {
          :site => 'https://telepass.me/api/user',
          :authorize_url => 'https://telepass.me/oauth/authorize',
          :token_url => 'https://telepass.me/oauth/token'
      }

      def request_phase
        super
      end

      def authorize_params
        super.tap do |params|
          %w[scope client_options].each do |v|
            if request.params[v]
              params[v.to_sym] = request.params[v]
            end
          end
        end
      end

      uid { raw_info.try(:[], 'id').to_s }

      info do
        {
            'first_name' => raw_info.try(:[], 'first_name'),
            'last_name' => raw_info.try(:[], 'last_name'),
            'username' => raw_info.try(:[], 'username'),
            'avatar' => raw_info.try(:[], 'avatar'),
        }
      end

      extra do
        {:raw_info => raw_info}
      end

      def raw_info
        access_token.options[:mode] = :query

        conn = Faraday.new(:url => "https://telepass.me")
        conn.authorization :Bearer, access_token.token

        @raw_info ||= MultiJson.load(conn.get('/api/user').body)
      end

      def callback_url
        full_host + script_name + callback_path
      end
    end
  end
end

OmniAuth.config.add_camelization 'telepass', 'Telepass'