# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user

  validates :content, presence: true, length: { maximum: 140 }

  scope :latest, -> {order(created_at: :desc)}
  # scope :follower, -> (follower_id:){ where(follower_id:).order(created_at: :desc) }
end
