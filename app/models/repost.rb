# frozen_string_literal: true

class Repost < ApplicationRecord
  after_create :create_notification

  belongs_to :user
  belongs_to :post
  has_one :notification, as: :action, dependent: :destroy

  validates :user_id, presence: true, uniqueness: { scope: :post_id }

  private

  def create_notification
    Notification.create!(user: post.user, action: self, action_type: self.class.name )
  end
end
