require "jwt"

module Auth
  class JWTService
    SECRET = ENV.fetch("JWT_SECRET") { "24b45f4a57efdba1747f3975d76a58296f6ca30feb51a249f47422bde8159b31daa9dc1c53feaff302f2f3878a73cfa2a39cb53d05a0eb9c2d891b6fde443be8" }

    def self.encode(payload, exp = 24.hours.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, SECRET, "HS256")
    end

    def self.decode(token)
      decoded = JWT.decode(token, SECRET, true, { algorithm: "HS256" })
      decoded.first.symbolize_keys
    rescue JWT::DecodeError
      nil
    end
  end
end
