class User < ApplicationRecord
  extend Enumerize

  validates :name, presence: true

  enumerize :gender, in: {
    male: 1,
    female: 2,
    unknown: 0
  }, default: :unknown, predicates: { prefix: true }, scope: true
end
