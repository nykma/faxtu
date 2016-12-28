class Admin < ApplicationRecord
  validates :name, presence: true

  has_many :logins, foreign_key: :user_id
end
