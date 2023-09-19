# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user

  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  validates :content, presence: true, length: { maximum: 140 }

  scope :latest, -> { order(created_at: :desc) }
  scope :followee_posts, ->(followee_ids:) { where(user_id: followee_ids).order(created_at: :desc) }

  delegate :name, :user_name, to: :user, prefix: true
end
