class LikesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :verify_policy_scoped, only: :index
  def index
    @likes = Like.where(user_id: current_user.id)
  end

  def new
    skip_authorization
  end

  def create

    @like = Like.new(user_id: current_user.id, pet_id: params[:pet_id])
    skip_authorization
    #@like.pet = @pet
    if @like.save
      flash[:alert] = "Pet Liked!"
      redirect_to pet_path(@like.pet)
    end
  end

  def destroy
    skip_authorization
    pet = Like.find(params[:id]).pet

    Like.find(params[:id]).destroy
    redirect_to pet_path(pet)
  end

  private

  def like_params
    params.require(:like).permit(:pet_id, :user_id)
  end

  def verify_policy_scoped
    true
  end

end
