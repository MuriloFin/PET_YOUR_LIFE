class PetsController < ApplicationController

  def index
    @pets = policy_scope(Pet).where(breed: search_params[:breed]).where(pet_type: search_params[:pet_type]).where(colour: search_params[:colour])
    @data = { dog: Pet::DOG_BREED, cat: Pet::CAT_BREED }
  end

  def new
    @pet = Pet.new
    authorize @pet
  end

  def create
    @pet = Pet.new(pet_params)
    authorize(@pet)
    @pet.user = current_user
    if @pet.save
      redirect_to pets_path
    else
      render :new
    end
  end

  def show
    skip_authorization
    @pet = Pet.find(params[:id])
    authorize(@pet)
    @chatrooms = Chatroom.where(pet_id: params[:id])
  end

  def edit
    @pet = Pet.find(params[:id])
    authorize(@pet)
  end

  def update
    @pet = Pet.find(params[:id])
    authorize(@pet)
    params[:pet][:adopted] = false if params[:pet][:adopted] == "false"
    if @pet.update(pet_params)
      if params[:pet][:adopted] == false
        redirect_to pets_path
      else
        redirect_to pet_path(@pet)
      end
    else
      render 'edit'
    end
  end

  def destroy
    @pet = Pet.find(params[:id])
    authorize(@pet)
    @pet.destroy
    redirect_to pets_path
  end

  def pet_params
    params.require(:pet).permit(:name, :pet_type, :breed, :colour, :size, :weight, :description, :photo, :adopted, :age, :gender)
  end

  private

  def search_params
    { breed: params[:breed].blank? ? Pet::DOG_BREED + Pet::CAT_BREED : params[:breed],
      pet_type: params[:breed].blank? ? Pet::PET_TYPE : params[:pet_type],
      colour: params[:colour].blank? ? Pet::COLOUR : params[:colour] }
  end

  def pundit_policy_scoped?
    true
  end
end
