# frozen_string_literal: true

# Note model
class Note < ApplicationRecord
  belongs_to :user
  belongs_to :conversation, dependent: :destroy

  validates :message, presence: true

  def send_alert_notification(c_user)
    return unless c_user.dietitian.present?

    NoteNotification.create!(
      notification_type: :note,
      content: "#{c_user.full_name} has written you",
      sender_id: c_user.id,
      associated_object_type: 'Note',
      associated_object_id: id,
      recipient_id: c_user.dietitian.id
    )
  end
end
