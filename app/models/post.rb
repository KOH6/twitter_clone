# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user

  validates :content, presence: true, length: { maximum: 140 }

  scope :latest, -> { order(created_at: :desc) }
  scope :followee_posts, ->(followee_ids:) { where(user_id: followee_ids).order(created_at: :desc) }
end
