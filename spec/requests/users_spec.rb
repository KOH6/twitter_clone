# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'サインアップ:POST devise/registrations#create' do
    let(:user) { create(:user) }
    let(:user_params) { attributes_for(:user) }
    let(:invalid_user_params) { attributes_for(:user, name:'') }

    context '正常系：パラメータ正常' do
      it 'requestが成功すること' do
        post user_registration_path, params: { user: user_params }
        expect(response).to have_http_status(303)
      end

      it '認証メールが送信されること' do
        post user_registration_path, params: { user: user_params }
        expect(ActionMailer::Base.deliveries.size).to eq 1
      end

      it 'ユーザcreateに成功すること' do
        expect do
          post user_registration_path, params: { user: user_params }
        end.to change(User, :count).by 1
      end

      it 'root_pathにリダイレクトされること' do
        post user_registration_path, params: { user: user_params }
        expect(response).to redirect_to root_url
      end
    end

    context '異常系：パラメータ不正' do
      it 'requestが成功すること' do
        post user_registration_path, params: { user: user_params }
        expect(response).to have_http_status(303)
      end

      it '認証メールが送信されること' do
        post user_registration_path, params: { user: user_params }
        expect(ActionMailer::Base.deliveries.size).to eq 1
      end

      it 'ユーザcreateに失敗すること' do
        expect do
          post user_registration_path, params: { user: invalid_user_params }
        end.to_not change(User, :count)
      end

      it 'responseにエラー文が含まれること' do
        post user_registration_path, params: { user: invalid_user_params }
        expect(response.body).to include 'エラーが発生したため ユーザー は保存されませんでした。'
      end
    end
  end

  describe 'ログイン:POST devise/sessions#create' do
    let(:user) { create(:user) }

    context '正常系：パラメータ正常' do
      before do
        user.confirm
        @user_params =  { email: user.email, password: user.password }
      end

      it 'requestが成功すること' do
        post user_session_path, params: { user: @user_params }
        expect(response).to have_http_status(303)
      end

      it 'ログイン状態になること' do
        post user_session_path, params: { user: @user_params }
        expect(controller.user_signed_in?).to be true
      end

      it 'root_pathにリダイレクトされること' do
        post user_session_path, params: { user: @user_params }
        expect(response).to redirect_to root_url
      end
    end

    context '異常系：パラメータ不正' do
      before do
        user.confirm
        @invalid_user_params =  { email: user.email, password: 'invalid' }
      end

      it 'requestが失敗すること' do
        post user_session_path, params: { user: @invalid_user_params }
        expect(response).to have_http_status(422)
      end

      it 'ログイン状態にならないこと' do
        post user_session_path, params: { user: @invalid_user_params }
        expect(controller.user_signed_in?).to be false
      end
    end
  end

end
