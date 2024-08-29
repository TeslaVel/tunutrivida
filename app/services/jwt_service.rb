require 'jwt'

class JwtService
  def self.key
    Rails.application.secret_key_base
  end

  def self.encode(payload)
    JWT.encode(payload, key, 'HS256') # 1 Hour , {'exp' => Time.now + 3600}
  end

  def self.decode(token)
    payload, = JWT.decode token, key, true, { algorithm: 'HS256' }
    # return nil if (header['exp'].nil? || Time.now > header['exp'])
    User.find_by(id: payload['user_id'])
  rescue JWT::DecodeError => e
    Rails.logger.warning "JWT Error #{e}"
    return nil
  end
end
