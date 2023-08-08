module Mutations
  class NoteMutation < BaseMutation
    description 'NoteMutation'
    argument :conversation_id, String, required: true
    argument :message, String, required: true

    field :note, Types::NoteType, null: true
    field :errors, [String], null: false

    def resolve(conversation_id:, message:)
      current_user = context[:current_user]

      #puts "mutation ### current_user #{current_user}"

      return { errors: ['Not logged'] } unless current_user.present?
      return { errors: ['User has not dietitian_id'] } unless current_user.dietitian.present?

      conversation = Conversation.find_by(id: conversation_id)

      unless conversation.present?
        conversation = Conversation.create(
          patient_id: current_user.id,
          dietitian_id: current_user.dietitian_id
        )
      end

      note = Note.new(
        user_id: current_user.id,
        conversation_id: conversation_id,
        message: message
      )


      if note.save
        # note.send_alert_notification(current_user)
        # moved into a model callback
      {
        id: note.id,
        message: note.message,
        created_at: note.created_at,
        user: note.user
      }
      else
        {errors: ['Error on note']}
      end
    end
  end
end

