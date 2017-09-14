class Review < ApplicationRecord
  belongs_to :user
  belongs_to :boardgame
  validates :rating, presence: true, numericality: true
end
