class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :content, presence: true

  scope :latest, -> { order(created_at: :desc) }
end
