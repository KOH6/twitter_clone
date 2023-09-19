# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.includes(:user).latest.page(params[:posts_page]).per(10)

    # 自分がいいねした投稿
    @like_posts = @user.like_posts.includes(:user).latest.page(params[:like_page]).per(10)
  end
end
