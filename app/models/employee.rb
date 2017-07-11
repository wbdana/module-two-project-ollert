class Employee < ApplicationRecord
  has_secure_password
  belongs_to :store
  has_many :employee_shifts
  has_many :shifts, through: :employee_shifts
end
