class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :authentication_keys => [:username]

  def email_required?
    false
  end

  def email_changed?
    false
  end

  validates :email, uniqueness: true
  validates :username, uniqueness: true

  has_one :patient_account, :class_name => "Patient", :foreign_key => "patient_id"
  has_many :patients, :foreign_key => "dietitian_id"
  has_many :user_roles
  has_many :roles, through: :user_roles

  include RolesConcern
  
  def add_role(role, created_by = nil)
  	# permited = Role::ROLES_TYPES.include?(role)
  	# return false unless permited
  	# newrole = Role::ROLES_TYPES[role].to_s
  	return false unless !self.has_role? role
  	exists_role = Role.find_by_name(role.to_s) || false
  	return false unless exists_role
    
    if created_by
  	 UserRole.create(user: self ,role: exists_role, created_by_id: created_by.id)
    else
     UserRole.create(user: self ,role: exists_role)
    end
  end
end
