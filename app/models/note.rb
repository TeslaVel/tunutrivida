# frozen_string_literal: true

# Note model
class Note < ApplicationRecord
  belongs_to :user
  belongs_to :conversation, dependent: :destroy
  after_create :create_notification

  validates :message, presence: true

  private

  def create_notification
    # for now only dietitian recieves notifications from patient
    return if user.is_patient? && user.dietitian.blank?

    # check if message if for user o dietitian.
    recipient_id = user.is_patient? ? user.dietitian.id : user.id
    # recipient_id = user.dietitian.id

    NoteNotification.create!(
      notification_type: :note,
      content: "#{user.full_name} has written you",
      sender_id: user.id,
      associated_object_type: 'Note',
      associated_object_id: id,
      recipient_id: recipient_id
    )
  end
end
