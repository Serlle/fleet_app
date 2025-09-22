class Auth::JwtEncoder
  def self.call(payload, exp = 2.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, ENV.fetch('JWT_SECRET'), "HS256")
  end
end