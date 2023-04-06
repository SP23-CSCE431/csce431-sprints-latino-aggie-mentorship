class User < ApplicationRecord
  # add new user to admin table if they do not already exist
  after_create :update_admin_record
  before_update :check_single_admin
  after_update :update_admin_record

  # validates fields to require
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: { message: "Email must be a valid TAMU email address" }
  validates :role, presence: { message: "Please select a role" }
  
  # implemented many to many relationship attribute
  has_many :course_users
  has_many :user_events
  has_many :consultations, through: :user_events
  has_many :courses, :through => :course_users
  accepts_nested_attributes_for :course_users


  def check_single_admin
    admin = Admin.find_or_initialize_by(email: self.email)
    if admin.role == "Admin" && Admin.where(role: "Admin").count == 1 && self.role != "Admin"
      errors.add(self.email, "exists as the only admin. There must be at least one admin user.")
      throw(:abort)
    end
  end

  def check_single_admin_destroy
    puts Admin.where(role: "Admin").count
    admin = Admin.find_or_initialize_by(email: self.email)
    if admin.role == "Admin" && Admin.where(role: "Admin").count == 1
      errors.add(self.email, "exists as the only admin. There must be at least one admin user.")
      return false
    else
      return true
    end
  end

  def update_admin_record
    admin = Admin.find_or_initialize_by(email: self.email)
    admin.role = self.role
    admin.save
  end
end
