# frozen_string_literal: true

# Comment model
class Comment < ApplicationRecord
  # belongs_to :user # , class_name: 'User', foreign_key: 'user_id'
  belongs_to :poster, class_name: 'User', foreign_key: 'user_id'
  belongs_to :entry
  # has_many :emoji_reactions, dependent: :destroy

  COMMENT_TPE = %i[
    text
    reaction
  ].freeze

  enum commen_type: COMMENT_TPE

  validates :message, presence: true
end
