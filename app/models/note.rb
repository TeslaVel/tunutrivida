# frozen_string_literal: true

# Note model
class Note < ApplicationRecord
  belongs_to :user
  belongs_to :conversation, dependent: :destroy

  validates :message, presence: true
end