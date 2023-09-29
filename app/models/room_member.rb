# frozen_string_literal: true

class RoomMember < ApplicationRecord
  belongs_to :user
  belongs_to :room
end
