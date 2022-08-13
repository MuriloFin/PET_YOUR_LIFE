class AdoptionsController < ApplicationController
  def index
    @adoption = policy_scope(Adoption)
  end

  def new
    @adoption = Adoption.new
    @pet = Pet.find(params[:pet_id])
  end

  def create
    @adoption = Adoption.new
    authorize(@adoption)
    @adoption.user = current_user
    @pet = Pet.find(params[:pet_id])
    @adoption.pet = @pet
    @pet.bought!
    if @adoption.save
      redirect_to planets_path
    else
      render :new
    end
  end

  def show
    authorize(@adoption)
    params.require(:adoption).permit(:pet_id)
  end
end
