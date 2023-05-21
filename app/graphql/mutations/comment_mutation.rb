module Mutations
  class CommentMutation < BaseMutation
    description 'CommentMutation'
    argument :entry_id, String, required: true
    argument :message, String, required: true
    argument :comment_type, Int, required: false

    field :comment, Types::CommentType, null: true
    field :errors, [String], null: false

    def resolve(entry_id:, message:)
      current_user = context[:current_user]

      #puts "mutation ### current_user #{current_user}"
      if current_user.present?
        comment = Comment.new(
          user_id: current_user.id,
          entry_id: entry_id,
          message: message,
          # comment_type: type
        )
        

        if comment.save
          comment.send_alert_notification(current_user)
          {
            id: comment.id,
            message: comment.message,
            created_at: comment.created_at,
            user: comment.user
          }
          
        else
          {errors: ['Error on comment']}
        end
      else
        {errors: ['Not logged']}
      end
    end
  end
end

