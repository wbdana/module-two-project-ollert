class Shift < ApplicationRecord
  has_many :employee_shifts
  has_many :employees, through: :employee_shifts
  belongs_to :manager
end
