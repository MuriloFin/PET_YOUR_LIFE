class PetsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :pundit_policy_scoped?, only: :index

  def index
    # if params[:query]
    #   @pets = Pet.global_search(params[:query])
    # else

    # end
    if params[:query].present?
      @pets = Pet.where("name ILIKE ?", "%#{params[:query]}%")
    else
      @pets = policy_scope(Pet)
    end
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
    @pet = Pet.find(params[:id])
    authorize(@pet)
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
    params.require(:pet).permit(:name, :type, :breed, :colour, :size, :weight, :description, :image, :adopted)
  end

  private

  def pundit_policy_scoped?
    true
  end
end
