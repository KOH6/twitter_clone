class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :action, polymorphic: true

  scope :latest, -> { order(created_at: :desc) }
end
