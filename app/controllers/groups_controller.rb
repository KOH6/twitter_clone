class GroupsController < ApplicationController
  before_action :set_user

  def index
    @groups = current_user.groups
    @other_users = @groups.map do |group|
      group.group_members.where.not(user_id: current_user.id).first.user
    end

  end

  def show
  end

  def create
  end
end
