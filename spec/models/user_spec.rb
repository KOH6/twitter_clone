# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context "バリデーション" do
    it "emailの正規表現が正しいこと" do
      user = build(:user)
      expect(user).to be_valid
    end
  end
end
