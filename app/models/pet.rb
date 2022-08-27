class Pet < ApplicationRecord
  belongs_to :user
  has_one_attached :photo
  has_many :adoptions, dependent: :destroy
  validate :name, :pet_type, :breed, :colour, :size, :age
  include PgSearch::Model
  PET_TYPE = ["Dog", "Cat"]
  DOG_BREED = ["Golden Retriever", "German Shepherd", "Jack Russell", "Sem Raça Definida"]
  CAT_BREED = ["Siamese", "Bengal", "Maine Coon", "Sem Raça Definida"]
  COLOUR = ["Black", "White", "Grey", "Brown", "Beige", "Multicolor"]
  SIZE = ["Small", "Medium", "Big"]
  AGE = ["Puppy", "Adult"]
  def adopted!
    self.update_attribute :adopted, true
  end
end
