class Store < ApplicationRecord
  belongs_to :city
  has_many :managers
  has_many :employees
end
