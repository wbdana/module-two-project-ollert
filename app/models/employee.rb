class Employee < ApplicationRecord
  has_secure_password
  belongs_to :store
  has_many :employee_shifts
  has_many :shifts, through: :employee_shifts

  validates :name, presence: true
  validates :email, presence: true
  validate :check_email
  validate :check_password

  def check_email
    if !self.persisted?
      if !(self.email.include?("@") && self.email.include?("."))
        errors.add(:email, "That's not an email!")
      end
      emails = Employee.all.map do |employee|
        employee.email
      end
      if emails.include?(self.email)
        errors.add(:email, "This email has already been used!")
      end
    end
  end

  def check_password
    if !self.persisted?
      if self.password.length < 4
        errors.add(:password, "Password must be at least 4 characters!")
      end
    end
  end

end
