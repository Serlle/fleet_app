class Auth::JwtDecoder
  def self.call(token)
    decoded = JWT.decode(token, ENV.fetch('JWT_SECRET'), true, { algorithm: 'HS256' })[0]
    HashWithIndifferentAccess.new decoded
  rescue JWT::DecodeError => e
    raise ExceptionHandler::InvalidToken, e.message
  end
end
