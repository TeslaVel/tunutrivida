class Appointment < ApplicationRecord
  belongs_to :patient
  belongs_to :dietitian, :class_name => "User", :foreign_key => "dietitian_id"
end
