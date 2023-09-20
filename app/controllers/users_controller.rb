# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.includes(:user).latest.page(params[:posts_page]).per(10)
    @liking_posts = @user.liking_posts.includes(:user).latest.page(params[:like_page]).per(10)
    @reposting_posts = @user.reposting_posts.includes(:user).latest.page(params[:repost_page]).per(10)
    @commenting_posts = @user.commenting_posts.includes(:user).latest.page(params[:comment_page]).per(10)
  end

  def edit
    if params[:id].to_i != current_user.id
      redirect_to root_path, flash: { danger: '自分以外のプロフィールは編集できません。' }
      return
    end
  end

  def update
    current_user.attributes = user_params
    if current_user.save(context: :not_new_form)
      redirect_to request.referer, flash: { success: 'プロフィールを更新しました。' }
    else
      redirect_to request.referer, flash: { danger: 'プロフィール更新失敗' }
    end
  end

  private

  def user_params
    params.require(:user).permit(%i[name introduction place website birthdate photo header_photo])
  end
end
