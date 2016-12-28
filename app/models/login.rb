# Store all login methods
class Login < ApplicationRecord
  devise :database_authenticatable, :trackable

  validates :login_token, :login_secret, :user_id, :user_type, presence: true
  validates :login_token, uniqueness: { case_sensitive: false }

  belongs_to :user, polymorphic: true
end
