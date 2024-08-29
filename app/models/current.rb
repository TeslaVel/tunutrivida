class Current < ActiveSupport::CurrentAttributes
  attribute :user
  attribute :user_id
  attribute :token

  resets { Time.zone = nil }

  def user=(user, token)
    super
    self.user = user
    self.user_id = user.id
    self.token = token
  end
end
