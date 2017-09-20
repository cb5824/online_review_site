class Boardgame < ApplicationRecord
  belongs_to :user
  has_many :reviews
  validates :title, presence: true
  validates :genre, presence: true

  def self.search(search)
    where("title ILIKE ? OR publisher ILIKE ? OR genre ILIKE ?", "%#{search}%", "%#{search}%", "%#{search}%")
  end
end
