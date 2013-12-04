require 'json'
require 'ostruct'
require 'core_ext/string'

module D2LValence
  module REST
    class Base < OpenStruct
      
      def underscore_keys(camel_hash)
        Hash[camel_hash.map { |k, v| [k.underscore, v] }]
      end
      
    end
  end
end