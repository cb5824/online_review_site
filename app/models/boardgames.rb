class Boardgame < ApplicationRecord
  belongs_to :user
  has_many :reviews
  validates :title, presence: true
  validates :genre, presence: true
end
