module Api
  module V1
    module Public
      class Register < Grape::API
        resource :register do
          desc "Register a new user"

          params do
            requires :username, type: String, regexp: /\A.+\z/, desc: "Username"
            requires :password, type: String, regexp: /\A.+\z/, desc: "Password"
          end

          post do
            user = ::User.new(declared(params))

            if user.save
              ::RegisterMailer.with(user: user).registered_mail.deliver_later
              status 201
              { message: "User created successfully" }
            else
              error!({ errors: user.errors.full_messages }, 422)
            end
          end
        end
      end
    end
  end
end
