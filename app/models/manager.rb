class Manager < ApplicationRecord
  belongs_to :store
  has_many :shifts
end
