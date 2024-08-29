module Mutations
  class ConversationMutation < BaseMutation
    description 'CommentMutation'
    argument :dietitian_id, String, required: true
    argument :message, String, required: false

    field :conversation, Types::ConversationType, null: true
    field :errors, [String], null: false

    def resolve(dietitian_id:, message:)
      current_user = context[:current_user]

      return {errors: ['Not logged']} unless current_user.present?

      di = dietitian_id.to_i
      conversation = Conversation.where(dietitian_id: di, patient_id: current_user.id).first

      if conversation.present?
        return conversation
      end

      conversation = Conversation.new(
        dietitian_id: di,
        patient_id: current_user.id
      )

      if conversation.save
        Note.create(
          user_id: current_user.id,
          conversation_id: conversation.id,
          message: message
        )

        return conversation
      else
        { errors: ['Error on comment'] }
      end
    end
  end
end

