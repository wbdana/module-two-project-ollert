class Employee < ApplicationRecord
  belongs_to :store
  has_many :employee_shifts
  has_many :shifts, through: :employee_shifts
end
