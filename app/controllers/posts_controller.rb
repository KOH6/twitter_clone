# frozen_string_literal: true

class PostsController < ApplicationController
  def index
    @user = user_signed_in? ? current_user : User.new
    @posts = Post.includes(:user).latest.page(params[:posts_page]).per(10)
    # 自分がフォローしている投稿
    followee_ids = @user.followees.map(&:id)
    @followee_posts = Post.includes(:user).followee_posts(followee_ids:).page(params[:followee_page]).per(10)
  end
end
