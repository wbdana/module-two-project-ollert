class Store < ApplicationRecord
  belongs_to :city
  has_many :employees

  #methods
  def num_of_employees
    self.employees.select{|employee| employee.is_manager == false}.count
  end

  def num_of_managers
    self.employees.select{|employee| employee.is_manager}.count
  end

  def shifts
    self.employees.map{|employee| employee.shifts}.flatten.uniq
  end

  def future_shifts
    shifts.select{|shift| shift.day > Time.now}
  end

  def past_shifts
    shifts.select{|shift| shift.day < Time.now}
  end

  def future_tasks
    future_shifts.map {|shift| shift.tasks}.flatten.reject{|task| task.description.length < 2 }
  end

  def past_tasks
    past_shifts.map {|shift| shift.tasks}.flatten.reject{|task| task.description.length < 2 }
  end


end
