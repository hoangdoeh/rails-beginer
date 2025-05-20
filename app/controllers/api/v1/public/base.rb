module Api
  module V1
    module Public
      class Base < Grape::API
        namespace :public do
          mount Api::V1::Public::Login
          mount Api::V1::Public::Register
        end
      end
    end
  end
end
