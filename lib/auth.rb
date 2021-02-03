# require 'jwt'

class Auth

  ALGORITHM = 'HS256'
#TODO to be removed
  Auth_secret = '\xDE\xF5>\x95\xF1\xFCz*\xA7\xDB\xC4h_(/\x1E>N\xA3\xB3d\xB0v\"\xE5\x8E\xDB\x15\xD29\xB2R'

  def self.issue(payload)
    JWT.encode(payload,Auth_secret,ALGORITHM)
  end

  def self.decode(token)
    JWT.decode(token,Auth_secret,true, {algorithm: ALGORITHM} ).first
  end

#TODO take salt from env
  # def self.auth_secret
  #   # ENV.fetch("AUTH_SECRET")
  #
  # end
end
