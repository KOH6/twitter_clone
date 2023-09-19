# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.includes(:user).latest.page(params[:posts_page]).per(10)
    @liking_posts = @user.liking_posts.includes(:user).latest.page(params[:like_page]).per(10)
    @reposting_posts = @user.reposting_posts.includes(:user).latest.page(params[:repost_page]).per(10)
    @commenting_posts = @user.commenting_posts.includes(:user).latest.page(params[:comment_page]).per(10)
  end
end
