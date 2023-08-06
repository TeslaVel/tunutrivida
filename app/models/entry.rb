# frozen_string_literal: true

# Entry model
class Entry < ApplicationRecord

  ENTRY_TYPES = %i[
    FoodEntry
    MetricEntry
    WorkoutEntry
    NoteEntry
    OtherEntry
  ].freeze

  enum entry_type: ENTRY_TYPES

  scope :food_entries, -> { where(type: 'FoodEntry') }
  scope :metric_entries, -> { where(type: 'MetricEntry') }
  scope :workout_entries, -> { where(type: 'WorkoutEntry') }
  scope :note_entries, -> { where(type: 'NoteEntry') }
  scope :other_entries, -> { where(type: 'OtherEntry') }

  belongs_to :user
  has_many :comments, dependent: :delete_all
  has_one_attached :image, dependent: :delete_all

  validates :description, presence: true
  validates :entry_type, presence: true
  # has_many :emoji_reactions, dependent: :destroy
end
