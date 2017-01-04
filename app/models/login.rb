# Store all login methods
class Login < ApplicationRecord
  devise :database_authenticatable, :trackable

  validates :login_token, :login_secret, :user_id, :user_type, :auth_token, presence: true
  validates :login_token, uniqueness: { case_sensitive: false }

  belongs_to :user, polymorphic: true

  after_initialize :generate_auth_token, if: proc { |login| login.auth_token.blank? }

  # Generate a random token
  # @return [Login] self
  def generate_auth_token
    self.auth_token = ::Devise.friendly_token(16)
    self
  end

  # For devise - parse encrypted password to login_secret
  # @param secret [String]
  # @return [String]
  def encrypted_password=(secret)
    self.login_secret = secret
  end

  # (see #encrypted_password=)
  def encrypted_password
    login_secret
  end
end
