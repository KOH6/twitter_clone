# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :system do
  before do
    user = create(:user)

    visit new_user_registration_path
    fill_in '名前', with: user.name
    fill_in 'ユーザー名', with: user.user_name
    fill_in 'Eメール', with: user.email
    fill_in '電話番号', with: user.phone
    fill_in '生年月日', with: user.birthdate
    fill_in 'パスワード', with: user.password
    fill_in 'パスワード（確認用）', with: user.password
    click_button '新規登録'
  end

  it 'サインアップ；正常系' do
    # メールが1通送信されること
    expect(ActionMailer::Base.deliveries.size).to eq 1
  end
end
