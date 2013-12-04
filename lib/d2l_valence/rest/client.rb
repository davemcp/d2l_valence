require 'd2l_valence/client'
require 'd2l_valence/rest/api/whoami_user'
require 'faraday'
require 'json'

module D2LValence
  module REST
    # Wrapper for the D2LValence REST API
    #
    class Client < D2LValence::Client
      # ENDPOINT = 'https://valence.desire2learn.com:443'
      WHOAMI = "/d2l/api/lp/1.0/users/whoami"
      
      def connection_options
        @connection_options ||= {
          :builder => middleware,
          :headers => {
            :accept => 'application/json',
          },
          :request => {
            :open_timeout => 5,
            :timeout => 10,
          },
        }
      end
            
      # @note Faraday's middleware stack implementation is comparable to that of Rack middleware.  The order of middleware is important: the first middleware on the list wraps all others, while the last middleware is the innermost one.
      # @see https://github.com/technoweenie/faraday#advanced-middleware-usage
      # @see http://mislav.uniqpath.com/2011/07/faraday-advanced-http/
      # @return [Faraday::Builder]
      def middleware
        @middleware ||= Faraday::Builder.new do |builder|
          # Convert file uploads to Faraday::UploadIO objects
          # builder.use Faraday::Request::MultipartWithFile
          # Checks for files in the payload
          builder.use Faraday::Request::Multipart
          # Convert request params to "www-form-urlencoded"
          builder.use Faraday::Request::UrlEncoded
          # Handle error responses
          # builder.use Faraday::Response::RaiseError
          # Parse JSON response bodies
          # builder.use Faraday::ParseJson
          # Set Faraday's HTTP adapter
          builder.adapter Faraday.default_adapter
        end
      end
      
      # Perform an HTTP GET request
      def get(path, params={})
        request(:get, path, params)
      end
      
      # return the an instance of the WhoAmI User
      def whoami
        set_d2l_connection_params("GET", WHOAMI)
        D2LValence::REST::API::WhoamiUser.new get(WHOAMI)
      end

      
      def set_d2l_connection_params(method, path)
        current_time_stamp = Time.now.to_i #Unix timestamp
        @d2l_connection_params = {
          :x_a => app_id,
          :x_b => user_id,
          :x_c => signed(method, path, app_key, current_time_stamp),
          :x_d => signed(method, path, user_key, current_time_stamp),
          :x_t => current_time_stamp
        }
      end
      
      def d2l_connection_params
        @d2l_connection_params
      end
      
      def signed(method, path, key, current_time_stamp)
        data = "#{method.upcase}&#{path}&#{current_time_stamp}"
        encoded_url_safe key, data
      end
      
      
    private
      # Returns a Faraday::Connection object
      #
      # @return [Faraday::Connection]
      def connection
        @connection ||= Faraday.new(end_point, connection_options)
      end
      
      def request(method, path, params={})
        params = params.merge(d2l_connection_params)
        response = connection.send(method.to_sym, path, params)
        response.env
      rescue Faraday::Error::ClientError, JSON::ParserError
        raise "There was a problem with the request: #{method} #{path}/#{params.to_s}"
      end
      
    end
    
  end
end
