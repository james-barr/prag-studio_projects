class Pledge < ApplicationRecord
  belongs_to :project

  Amount = [
    1, 5, 10, 20, 50, 100, 250, 500, 1000
  ]

  validates :name, :location, presence: true

  validates :email, format: { with: /.+@.+/,
    message: "Improperly formatted email"}

  validates :pledge, inclusion: {in: Amount,
    message: "Please select from available pledge amounts"},
    numericality: { only_integer: true}

  validates :comment, length: {minimum: 25, maximum: 150}, allow_blank: true
end
