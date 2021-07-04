class Shift < ApplicationRecord
  has_many :employee_shifts
  has_many :employees, through: :employee_shifts
  has_many :tasks

  validates :day, :start_time, :end_time, :manager_id, presence: true
  validate :check_employees
  validate :check_date
  validate :check_end_time

  accepts_nested_attributes_for :tasks

  def check_end_time
    if self.end_time < self.start_time
      self.errors.add(:start_time, "-- You trying to start before you finish?? ¯\\_(ツ)_/¯")
    end
  end

  def check_date
    if self.day.to_date < Date.today
      self.errors.add(:day, "-- No time traveling during business hours")
    end
  end

  def manager
    Employee.find(self.manager_id)
  end

  def check_employees
    if self.employees.length < 2
      self.errors.add(:employee_ids, "-- You need at least two employees per shift!")
    end
  end

  #methods
  def hours
    (self.end_time - self.start_time) / 100
  end

  def num_of_employees
    self.employees.size
  end

  def shift_week
    self.day.to_date.strftime('%U')
  end

  def shift_day
    self.day.to_date.strftime('%A')
  end

  def shift_month
    self.day.to_date.strftime('%B')
  end

  def shift_year
    self.day.to_date.strftime('%Y')
  end

  def sec_since_1970
    # just because we can
    # fun fact
    # #WeWereShortAMethod     ¯\\_(ツ)_/¯
    self.day.to_date.strftime('%s')
  end

  def formatted_start_time
    if self.start_time < 1200
      return "#{self.start_time/100}:00am"
    else
      return "#{(self.start_time-1200)/100}:00pm"
    end
  end
  def formatted_end_time
    if self.end_time< 1200
      return "#{self.end_time/100}:00am"
    else
      return "#{(self.end_time-1200)/100}:00pm"
    end
  end
end
