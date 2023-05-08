# frozen_string_literal: true

# Comment model
class Comment < ApplicationRecord
  belongs_to :user # , class_name: 'User', foreign_key: 'user_id'
  belongs_to :entry
end
