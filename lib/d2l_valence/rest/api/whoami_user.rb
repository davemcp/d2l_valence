require 'd2l_valence/rest/base'

module D2LValence
  module REST
    module API
      class WhoamiUser < D2LValence::REST::Base
        def initialize(response_hash)
          # we only want the body of the response
          body_hash = underscore_keys JSON.parse(response_hash[:body])
          super body_hash
        end
      end
    end
  end
end