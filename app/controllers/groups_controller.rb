class GroupsController < ApplicationController
  before_action :set_user
  before_action :set_group_infos, only: %i[index show]

  def index; end

  def show
    group = current_user.groups.find(params[:id])
    @messages = group.messages.includes(:user).latest
  end

  def create
  end

  private

  def set_group_infos
    @group_infos = []
    groups = current_user.groups.distinct
    groups.map do |group|
      group_info = {}
      group_info[:group_id] = group.id
      group_info[:user] = group.group_members.where.not(user_id: current_user.id).first.user
      @group_infos << group_info
    end
  end
end
