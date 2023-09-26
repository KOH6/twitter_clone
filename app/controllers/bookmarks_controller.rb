class BookmarksController < ApplicationController
  before_action :set_user

  def index
    @bookmarking_posts = @user.bookmarking_posts.includes(:user, :likes, :reposts, :bookmarks).latest.page(params[:page]).per(10)
  end

  def create
  end

  def destroy
  end
end
