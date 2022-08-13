class AdoptionsController < ApplicationController
  def index
    
  end

  def new
    @pet = Adoption.new
    @pet = Pet.find(params[:pet_id])
  end

  def create
    @pet = Pet.new
    @pet.user = current_user
  end

  def show

  end
end
