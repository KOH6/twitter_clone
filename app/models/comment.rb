# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many_attached :images

  validates :content, presence: true

  scope :latest, -> { order(created_at: :desc) }

  delegate :name, :user_name, to: :user, prefix: true
end
