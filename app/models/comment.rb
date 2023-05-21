# frozen_string_literal: true

# Comment model
class Comment < ApplicationRecord
  # belongs_to :poster, class_name: 'User', foreign_key: 'user_id'
  belongs_to :user
  belongs_to :entry
  # has_many :emoji_reactions, dependent: :destroy

  COMMENT_TPE = %i[
    text
    reaction
  ].freeze

  enum commen_type: COMMENT_TPE

  validates :message, presence: true

  def send_alert_notification(c_user)
    return unless c_user.dietitian.present?

    CommentNotification.create!(
      notification_type: :comment,
      content: "#{c_user.full_name} has sent you a comment",
      sender_id: c_user.id,
      associated_object_type: 'Comment',
      associated_object_id: id,
      recipient_id: c_user.dietitian.id
    )
  end
end
