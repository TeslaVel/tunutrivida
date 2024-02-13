# frozen_string_literal: true

# Comment model
class Comment < ApplicationRecord
  # belongs_to :poster, class_name: 'User', foreign_key: 'user_id'
  belongs_to :user
  belongs_to :entry
  after_create :create_notification
  # has_many :emoji_reactions, dependent: :destroy

  COMMENT_TPE = %i[
    text
    reaction
  ].freeze

  enum comment_type: COMMENT_TPE

  validates :message, presence: true

  def create_notification
    # for now only the dietitian recieves notifications from patient
    return unless user.is_patient? && user.dietitian.present?

    # check if message if for user o dietitian.
    # recipient = user.is_patient? ? user.dietitian.id :  user.id
    recipient_id = user.dietitian.id

    CommentNotification.create!(
      notification_type: :comment,
      content: "#{user.full_name} has commented to you",
      sender_id: user.id,
      associated_object_type: 'Comment',
      associated_object_id: id,
      recipient_id: recipient_id
    )
  end
end
