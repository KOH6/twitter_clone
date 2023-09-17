# frozen_string_literal: true

class PostsController < ApplicationController
  def index
    @user = user_signed_in? ? current_user : User.new
    @posts = Post.latest
    # 自分がフォローしている人
    @followees = @user.followees
    followee_ids = @followees.map(&:id)
    @followee_posts = Post.followee_posts(followee_ids:)
  end
end
