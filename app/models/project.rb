class Project < ApplicationRecord
  has_many :pledges, dependent: :destroy
  has_many :follows, dependent: :destroy
  has_many :followers, through: :follows, source: :user
  has_many :characterizations, dependent: :destroy
  has_many :types, through: :characterizations

  before_validation :set_slug

  validates :name, :slug, presence: true, uniqueness: true
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

    scope :find_all, -> { order(name: :desc) }
    scope :pledging_ended, -> { find_all.where('pledging_ends_on < ?', Date.today ) }
    scope :pledging, -> { find_all.where('pledging_ends_on > ?', Time.now) }
    scope :past_n_days, -> (n=30) { find_all.where('created_at >= ?', n.days.ago)}
    scope :target_greater_than, -> (amount) { find_all.where('target_pledge_amount > ?', amount) }
    scope :target_less_than, -> (amount) { find_all.where('target_pledge_amount < ?', amount) }

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

  def to_param
    slug
  end

  def set_slug
    self.slug ||= name.parameterize if name
  end

end
