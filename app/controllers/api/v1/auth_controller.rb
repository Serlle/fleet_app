module Api
  module V1
    class AuthController < BaseController
      skip_before_action :authenticate_api!, only: [:login]

      # POST /api/v1/auth/login
      def login
        u = params[:username].to_s
        p = params[:password].to_s

        if u == ENV['AUTH_USERNAME'] && p == ENV['AUTH_PASSWORD']
          token = Auth::JwtEncoder.call({ sub: "admin", role: "manager" })
          render json: { token: token }, status: :ok
        else
          render_error(code: 'unauthorized', message: 'Invalid credentials - username or password', status: :unauthorized)
        end
      end
    end
  end
end
