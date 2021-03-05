class Transaction < ApplicationRecord
  belongs_to :user
  validates :amount, presence: true
  validates :origin_currency, presence: true
  validates :destination_currency, presence: true
end
