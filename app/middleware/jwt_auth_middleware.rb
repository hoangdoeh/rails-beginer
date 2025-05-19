# frozen_string_literal: true

require "jwt"

class JwtAuthMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)

    Rails.logger.info "Use middleware"
    # Bỏ qua các route công khai
    if request.path.start_with?("/api/v1/public")
      return @app.call(env)
    end

    unless request.path.start_with?("/api/v1/")
      return @app.call(env)
    end

    # Lấy JWT từ header
    auth_header = request.get_header("HTTP_AUTHORIZATION")

    if auth_header&.start_with?("Bearer ")
      token = auth_header.split(" ").last

      begin
        payload = JsonWebToken.decode(token)
        unless payload
          return unauthorized("Missing or malformed Authorization header")
        end
        env["jwt.payload"] = payload # Gắn payload vào env để controller có thể dùng
        user = User.find(payload["sub"])
        unless user
          return unauthorized("User not found")
        end
        env["user"] = user
        @app.call(env)
      rescue JWT::DecodeError => e
        unauthorized("Invalid token: #{e.message}")
      end
    else
      unauthorized("Missing or malformed Authorization header")
    end
  end

  private

  def unauthorized(message)
    [
      401,
      { "Content-Type" => "application/json" },
      [ { error: message }.to_json ]
    ]
  end
end
