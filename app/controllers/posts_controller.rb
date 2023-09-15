# frozen_string_literal: true

class PostsController < ApplicationController
  def index
    @user = if user_signed_in?
              current_user
            else
              User.new
            end
  end
end
