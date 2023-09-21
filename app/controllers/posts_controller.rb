# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_user_and_posts

  def index; end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to request.referer
    else
      render :index
    end
  end

  private

  def set_user_and_posts
    @user = user_signed_in? ? current_user : User.new
    @post = Post.new
    @posts = Post.includes(:user).latest.page(params[:posts_page]).per(10)
    # 自分がフォローしている投稿
    followee_ids = @user.followees.map(&:id)
    @followee_posts = Post.includes(:user).followee_posts(followee_ids:).page(params[:followee_page]).per(10)
  end

  def post_params
    params.require(:post).permit(:content, images: [])
  end
end
