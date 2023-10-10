# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :system do
  describe 'サインアップ' do
    context '正常系のとき' do
      let(:user) { build(:user) }

      scenario 'ユーザ登録' do
        expect do
          visit new_user_registration_path
          fill_in '名前', with: user.name
          fill_in 'ユーザー名', with: user.user_name
          fill_in 'Eメール', with: user.email
          fill_in '電話番号', with: user.phone
          fill_in '生年月日', with: user.birthdate
          fill_in 'パスワード', with: user.password
          fill_in 'パスワード（確認用）', with: user.password

          click_button '新規登録'
        end.to change(User, :count).by 1

        # メールが1通送信されること
        expect(ActionMailer::Base.deliveries.size).to eq 1
      end
    end

    context '異常系のとき' do
      let(:user) { build(:user) }
      let(:user2) { create(:user) }

      before do
        user2.confirm
      end

      scenario 'ユーザ登録' do
        expect do
          visit new_user_registration_path
          fill_in '名前', with: user.name
          fill_in 'ユーザー名', with: user.user_name
          fill_in 'Eメール', with: user2.email
          fill_in '電話番号', with: user.phone
          fill_in '生年月日', with: user.birthdate
          fill_in 'パスワード', with: user.password

          click_button '新規登録'
        end.to change(User, :count).by 0

        # エラーが表示されること
        expect(page).to have_content 'エラーが発生したため ユーザー は保存されませんでした。'
      end
    end
  end
end
