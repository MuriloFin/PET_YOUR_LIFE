class PetsController < ApplicationController

  def index
    skip_authorization
    # if params[:query]
    #   @pets = Pet.global_search(params[:query])
    # else

    # end
    if params[:query].present?
      @pets = Pet.where("name ILIKE ?", "%#{params[:query]}%")
    else
      @pets = policy_scope(Pet)
    end

    @markers = @pets.geocoded.map do |pet|
      {
        lat: pet.latitude,
        lng: pet.longitude,
        #info_window: render_to_string(partial: "info_window", locals: { pet: pet })
      }
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
    skip_authorization
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
    params.require(:pet).permit(:name, :pet_type, :breed, :colour, :size, :weight, :description, :photo, :adopted)
  end

  private

  def pundit_policy_scoped?
    true
  end
end
