class ChatroomsController < ApplicationController
  before_action :authenticate_user!
  def show
    @chatroom = Chatroom.find(params[:id])
    authorize(@chatroom)
    @message = Message.new
  end

  def create
    @pet = Pet.find(params[:pet_id])
    @chatroom = Chatroom.where(user: current_user, pet: @pet).first
    @chatroom = Chatroom.create(name: @pet.name, pet: @pet, user: current_user) if @chatroom.nil?
    authorize(@chatroom)
    @chatroom.save
    redirect_to @chatroom
  end
end
