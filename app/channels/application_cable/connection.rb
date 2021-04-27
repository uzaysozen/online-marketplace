require 'jwt'

module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private
    def find_verified_user
      token = request.query_parameters[:token]
      if token
        decoded_token = JWT.decode token, '5|_||>E.-5e(.-e7|<e`/', true, {algorithm: 'HS256'}
        user_id = decoded_token[0]["user_id"]
        User.find_by_id(user_id)
      end
    end
  end
end
