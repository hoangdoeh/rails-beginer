module Api
  class Base < Grape::API
    format "json"
    prefix "api"

    rescue_from Grape::Exceptions::ValidationErrors do |e|
      error!(e.message, 422)
    end

    mount Api::V1::Base
  end
end
