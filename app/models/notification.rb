# frozen_string_literal: true

# Note model
class Notification < ApplicationRecord
  belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'
  belongs_to :recipient, class_name: 'User', foreign_key: 'recipient_id'

  NOTIFICATION_TYPES = %i[
    CommentNotification
    EntryNotiffication
  ].freeze

  enum notification_type: NOTIFICATION_TYPES
end
