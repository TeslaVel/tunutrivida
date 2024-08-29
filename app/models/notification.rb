# frozen_string_literal: true

# Note model
class Notification < ApplicationRecord
  belongs_to :sender, class_name: 'User', foreign_key: 'sender_id', optional: true
  belongs_to :recipient, class_name: 'User', foreign_key: 'recipient_id', optional: true
  belongs_to :associated_object, polymorphic: true

  NOTIFICATION_TYPES = %i[
    comment
    entry
    contactus
    note
  ].freeze

  enum notification_type: NOTIFICATION_TYPES
end
