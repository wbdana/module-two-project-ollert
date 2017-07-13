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

  #methods

  def total_hours_worked
    self.shifts.map{|shift| shift.hours}.inject(:+)
  end

  def employee_tasks
    self.shifts.map {|shift| shift.tasks}.flatten.reject{|task| task.description.length < 2 }
  end

  def num_of_tasks
    employee_tasks.count
  end

  def past_shifts
    self.shifts.select{|shift| shift.day < Time.now}
  end

  def future_shifts
    self.shifts.select{|shift| shift.day > Time.now}
  end

  def total_days_worked
    past_shifts.map{|shift| shift.day}.uniq.count
  end

  def total_days_to_work
    future_shifts.map{|shift| shift.day}.uniq.count
  end

end
