module ApplicationCable
  class Connection < ActionCable::Connection::Base
    include ActionController::Cookies
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private
      def find_verified_user
        puts "####### headers id #{request.params}"
        token = request&.params['token']
        user_id = if token
                    user = JwtService.decode(token)
                    user&.id
                  elsif cookies.encrypted[:_sb_admin_session].present? && cookies.encrypted[:_sb_admin_session]['user_id'].present?
                    cookies.encrypted[:_sb_admin_session]['user_id']
                  end

        if user_id.present?
          return User.find_by(id: user_id)
          # else
          #   reject_unauthorized_connection
        end

        false
      end
  end
end
