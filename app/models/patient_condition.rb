# PatientCondition
class PatientCondition < ApplicationRecord
  belongs_to :condition
  belongs_to :created_by, class_name: 'User', foreign_key: 'created_by_id'
  belongs_to :patient, class_name: 'User', foreign_key: 'patient_id'
end
