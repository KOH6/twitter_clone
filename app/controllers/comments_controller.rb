# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.post_id = params[:post_id].to_i

    if @comment.save
      redirect_to request.referer
    else
      redirect_to request.referer, flash: { danger: 'コメント投稿に失敗しました。' }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, images: [])
  end
end
