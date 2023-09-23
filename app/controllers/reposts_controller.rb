# frozen_string_literal: true

class RepostsController < ApplicationController
  def create
    @repost = current_user.reposts.create(post_id: params[:post_id])
    redirect_to request.referer
  end

  def destroy
    @repost = Repost.find_by(post_id: params[:post_id], user_id: current_user.id)
    @repost.destroy
    redirect_to request.referer
  end
end
