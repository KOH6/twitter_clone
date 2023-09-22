# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :user, presence: true, uniqueness: { scope: :post }
end
