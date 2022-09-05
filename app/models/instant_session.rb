class InstantSession < ApplicationRecord
  belongs_to :created_by, :class_name => "User", :foreign_key => "created_by_id"
  belongs_to :activity_factor
  belongs_to :gender
  before_create :set_imc

  def set_imc
    h2 = (height*height).round(2)
    self.imc = (weight / h2 ).round(2)
  end

  def destroy_instant_session
  end
end
