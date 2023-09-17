class Follow < ApplicationRecord
  belongs_to :follower, class_name: User.to_s
  belongs_to :followee, class_name: User.to_s

  validates :follower_id, presence: true
  validates :followee_id, presence: true
end
