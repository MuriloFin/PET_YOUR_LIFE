class Pet < ApplicationRecord
  belongs_to :user
  has_one_attached :photo
  has_many :adoptions, dependent: :destroy
  validate :name, :pet_type, :breed, :colour, :size, :weight
  include PgSearch::Model
  pg_search_scope :pet_type_search,
    against: %i[pet_type]
  pg_search_scope :breed_search,
    against: %i[breed]
  pg_search_scope :colour_search,
    against: %i[colour]
  PET_TYPE = ["Dog", "Cat"]
  DOG_BREED = ["Golden Retriever", "German Shepherd", "Jack Russell", "Caramelo Do Brasil"]
  CAT_BREED = ["Siamese", "Bengal", "Maine Coon", "Gato Comum"]
  #Make BREED dependent from PET_TYPE (i.e. if pet_type = cat, breed appearing are cat breeds only)
  COLOUR = ["Black", "White", "Grey", "Brown", "Beige", "Multicolor"]
  #WEIGHT? SIZE?
  def adopted!
    self.update_attribute :adopted, true
  end
end
