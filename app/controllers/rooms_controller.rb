# frozen_string_literal: true

class RoomsController < ApplicationController
  before_action :set_user
  before_action :set_room_infos, only: %i[index show]

  def index; end

  def show
    room = current_user.rooms.find(params[:id])
    @messages = room.messages.includes(:user).latest
  end

  def create; end

  private

  def set_room_infos
    @room_infos = []
    rooms = current_user.rooms.distinct
    rooms.map do |room|
      room_info = {}
      room_info[:room_id] = room.id
      room_info[:user] = room.room_members.where.not(user_id: current_user.id).first.user
      @room_infos << room_info
    end
  end
end
