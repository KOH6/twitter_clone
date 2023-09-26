# frozen_string_literal: true

class Repost < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :user_id, presence: true, uniqueness: { scope: :post_id }
end
