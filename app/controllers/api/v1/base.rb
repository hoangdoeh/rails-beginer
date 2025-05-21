module Api
  module V1
    class Base < Grape::API
      version "v1", using: :path
      mount Api::V1::Public::Base
      mount Api::V1::Todos
      mount Api::V1::Me
    end
  end
end
