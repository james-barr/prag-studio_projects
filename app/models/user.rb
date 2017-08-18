class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    format: { with: /\A\S+@\S+\z/}
  validates :username, presence: true,
                      format: { with: /\A[a-zA-Z\d]+\z/i },
                      uniqueness: { case_sensitive: false }

  def gravatar_id
    Digest::MD5.hexdigest(email.downcase)
  end
end
