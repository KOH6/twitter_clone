class UsersController < ApplicationController
  def show
    @user = user_signed_in? ? current_user : User.new
    @posts = @user.posts.latest.page(params[:posts_page]).per(10)
  end
end
