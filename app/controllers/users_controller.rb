class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.latest.page(params[:posts_page]).per(10)
  end
end
