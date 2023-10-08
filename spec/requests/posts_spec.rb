# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '`Posts', type: :request do
  describe 'ツイート:POST posts#create' do
    let(:user) { create(:user) }

    context '正常系：パラメータ正常' do
      before do
        user.confirm
        sign_in user
        @post_params =  { content: 'テスト投稿' }
      end

      it 'requestが成功すること' do
        post posts_path, params: { post: @post_params }, headers: { HTTP_REFERER: root_url }
        expect(response).to have_http_status(302)
      end

      it 'ツイートcreateに成功すること' do
        expect do
          post posts_path, params: { post: @post_params }, headers: { HTTP_REFERER: root_url }
        end.to change(Post, :count).by 1
      end

      it 'root_pathにリダイレクトされること' do
        post posts_path, params: { post: @post_params }, headers: { HTTP_REFERER: root_url }
        expect(response).to redirect_to root_url
      end
    end

    context '異常系：パラメータ不正' do
      before do
        user.confirm
        sign_in user
        @post_params =  { content: '' }
      end

      it 'requestが成功すること' do
        post posts_path, params: { post: @post_params }
        expect(response).to have_http_status(200)
      end

      it 'responseにエラー文が含まれること' do
        post posts_path, params: { post: @post_params }
        expect(response.body).to include 'エラーが発生したため 投稿 は保存されませんでした。'
      end
    end
  end

end
