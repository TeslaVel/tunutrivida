module Mutations
  class LogoutMutation < BaseMutation
    description 'LogoutMutation'
    field :success, Boolean, null: false

    def resolve
      context[:current_user] = nil
      { success: true }
    end
  end
end
