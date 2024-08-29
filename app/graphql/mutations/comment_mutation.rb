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

      return { errors: ['Not logged'] } unless current_user.present?
      return { errors: ['User has not dietitian_id'] } unless current_user.dietitian.present?

      comment = Comment.new(
        user_id: current_user.id,
        entry_id: entry_id,
        message: message
        # comment_type: type
      )

      if comment.save
        # comment.send_alert_notification(current_user)
        # moved to a model callback
        comment
      else
        { errors: ['Error on comment'] }
      end
    end
  end
end
