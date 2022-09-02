class PetsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  def index
    if params[:query]
      @pets = Pet.global_search(params[:query])
    elsif params[:filter]
      # {"pet_type"=>"Cachorro", "breed"=>"Sem Raça Definida", "colour"=>"", "size"=>"", "age"=>""}
      where = {}
      params[:filter].each do |key, value|
      next if value == ""
        where[key] = value
      end
      @pets = Pet.where(where)
      # @pets = Pet.global_search(params[:filter][:pet_type])
    else
      @pets = policy_scope(Pet)
    end
    # end
    # if params[:query].present?
    #   @pets = Pet.where("name ILIKE ?", "%#{params[:query]}%")
    # elsif params[:colour] != ''
    #   @pets = policy_scope(Pet).where(breed: search_params[:breed]).where(pet_type: search_params[:pet_type]).where(colour: search_params[:colour])
    # else

    @data = { dog: Pet::DOG_BREED, cat: Pet::CAT_BREED }

    @markers = @pets.geocoded.map do |pet|
      {
        lat: pet.latitude,
        lng: pet.longitude,
        #info_window: render_to_string(partial: "info_window", locals: { pet: pet })
      }
    end
  end

  def new
    @data = { dog: Pet::DOG_BREED, cat: Pet::CAT_BREED }
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
    @data = { dog: Pet::DOG_BREED, cat: Pet::CAT_BREED }
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
