class Room < ApplicationRecord
  has_many :room_members, dependent: :destroy
  has_many :messages, dependent: :destroy
end
