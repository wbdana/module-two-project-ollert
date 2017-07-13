class City < ApplicationRecord
  has_many :stores

  #methods

  def num_of_managers_in_city
    self.stores.map{|store| store.num_of_managers}.flatten.inject(:+)
  end

  def num_of_associates_in_city
    self.stores.map{|store| store.num_of_employees}.flatten.inject(:+)
  end

  def num_of_total_employees
    num_of_managers_in_city + num_of_associates_in_city
  end
end
