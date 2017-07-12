class Shift < ApplicationRecord
  has_many :employee_shifts
  has_many :employees, through: :employee_shifts
  has_many :tasks

  validates :day, :start_time, :end_time, :manager_id, presence: true
  validate :check_employees


  accepts_nested_attributes_for :tasks

  def manager
    Employee.find(self.manager_id)
  end

  def check_employees
    if self.employees.length < 2
      self.errors.add(:employee_ids, "You need at least two employees per shift!")
    end
  end

end
