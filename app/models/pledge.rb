class Pledge < ApplicationRecord
  belongs_to :project
  belongs_to :user

  Amount = [
    1, 5, 10, 20, 50, 100, 250, 500, 1000
  ]

  validates :location, presence: true

  validates :pledge, inclusion: {in: Amount,
    message: "Please select from available pledge amounts"},
    numericality: { only_integer: true}

  validates :comment, length: {minimum: 25, maximum: 150}, allow_blank: true

  scope :past_n_days, -> (n=30) { where 'created_at >= ?', n.days.ago }
end
