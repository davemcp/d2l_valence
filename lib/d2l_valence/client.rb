require 'd2l_valence/version'
require 'uri'
require "openssl"
require "base64"


module D2LValence
  class Client
    attr_accessor :end_point, :app_id, :app_key, :user_id, :user_key

    # Initializes a new Client object
    #
    # @param options [Hash]
    # @return [D2LValence::Client]
    def initialize(options={})
      options.each do |key, value|
        send(:"#{key}=", value)
      end
      yield self if block_given?
      validate_credential_type!
    end

    # @return [String]
    def user_agent
      @user_agent ||= "D2LValence Ruby Gem #{D2LValence::Version}"
    end

    # @return [Hash]
    def credentials
      {
        :end_point    => end_point,
        :app_key      => app_key,
        :app_id       => app_id,
        :user_id      => user_id,
        :user_key    => user_key
      }
    end

    # @return [Boolean]
    def credentials?
      credentials.values.all?
    end

  private

    # Ensures that all credentials set during configuration are of a
    # valid type. Valid types are String and Symbol.
    #
    # Error is raised when
    #   supplied D2LValence credentials are not a String or Symbol.
    def validate_credential_type!
      credentials.each do |credential, value|
        next if value.nil?
        raise(Error::ConfigurationError, "Invalid #{credential} specified: #{value.inspect} must be a string or symbol.") unless value.is_a?(String) || value.is_a?(Symbol)
      end
    end
    
    def encoded_url_safe(key, data)
      digest = OpenSSL::Digest::Digest.new("sha256")
      hmac = OpenSSL::HMAC.digest(digest, key, data)
      encoded_url_safe = Base64.urlsafe_encode64(hmac).gsub!(/=+$/, "")
    end

  end
end
