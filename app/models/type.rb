class Type < ApplicationRecord
  has_many :characterizations, dependent: :destroy
  has_many :projects, through: :characterizations

end
