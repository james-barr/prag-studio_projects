class Project < ApplicationRecord
  has_many :pledges, dependent: :destroy

  validates :name, presence: true

  validates :description, length: { minimum: 25, maximum: 150}

  validates :target_pledge_amount, numericality: {greater_than_or_equal_to: 0}

  validates :team_members, format: {
    with: /\A[a-zA-Z]+\,?(\s?[a-zA-Z]+\,?\s?)*[a-zA-Z]\z/,
    message: "Words, only"}

  validates :website, format: {with: /(http)[s]?(:\/\/www.)[\-\w]+\.{1}\w+\z/,
    message: "Not a valid url, example of a good url: http://www.example.org"
  }

  validates :image_file_name, format: { with: /.+\.(jpg|gif|png)/i,
    message: "File must be a png, gif, or jpg"}, allow_blank: true

  def ended?
    pledging_ends_on == nil || pledging_ends_on < 0.days.from_now
  end

  def self.in_progress
    where("pledging_ends_on >= ?", Time.now).order("pledging_ends_on")
  end

  def sum_pledges
    pledges.all.sum(:pledge)
  end

  def remaining_pledge
    target_pledge_amount - sum_pledges
  end

  def fully_funded?
    remaining_pledge.zero?
  end

end
