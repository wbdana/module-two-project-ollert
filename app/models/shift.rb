class Shift < ApplicationRecord
  has_many :employee_shifts
  has_many :employees, through: :employee_shifts

  def manager
    Employee.find(self.manager_id)
  end

end
