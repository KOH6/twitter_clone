class Message < ApplicationRecord
  belongs_to :user
  belongs_to :group

  validates :content, presence: true

  scope :latest, -> { order(created_at: :desc) }
end
