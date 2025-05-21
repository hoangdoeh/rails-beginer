module Grape
  class Endpoint
    alias_method :original_present, :present

    def present(*args)
      object = args[0]
      options = args[1] || {}

      if !options[:with] && defined?(ActiveModel::Serializer)
        serializer = ActiveModel::Serializer.serializer_for(object)
        if serializer
          return original_present(JSON.parse(serializer.new(object).to_json))
        end
      end

      original_present(*args)
    end
  end
end
