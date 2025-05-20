module Api
  module V1
    module Public
      class Login < Grape::API
        resource :login do
          desc "Login with username and password"
          post do
            user = User.find_by(username: params[:username])
            if user&.authenticate(params[:password])
              token = JsonWebToken.encode(sub: user.id)
              { token: token }
            else
              error!("Unauthorized", 401)
            end
          end
        end
      end
    end
  end
end
