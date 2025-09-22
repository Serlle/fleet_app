# app/controllers/concerns/authenticable.rb
module Authenticable
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_api!
    attr_reader :current_claims
  end

  def authenticate_api!
    header = request.headers["Authorization"].to_s
    scheme, token = header.split(" ", 2)
    return render_unauthorized("missing_token") unless scheme == "Bearer" && token.present?

    @current_claims = Auth::JwtDecoder.call(token)
  rescue JWT::ExpiredSignature
    render_unauthorized("token_expired")
  rescue JWT::DecodeError
    render_unauthorized("invalid_token")
  end

  def render_unauthorized(code)
    render_error(code: code, message: "Unauthorized", status: :unauthorized)
  end
end
