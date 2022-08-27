class Pet < ApplicationRecord
  belongs_to :user
  has_one_attached :photo
  has_many :adoptions, dependent: :destroy
  has_many :chatrooms, dependent: :destroy
  validate :name, :pet_type, :breed, :colour, :size, :weight, :age
  include PgSearch::Model
  PET_TYPE = ["Cachorro", "Gato"]
  DOG_BREED = ["Golden Retriever", "German Shepherd", "Jack Russell", "Sem Raça Definida"]
  CAT_BREED = ["Siamese", "Bengal", "Maine Coon", "Sem Raça Definida"]
  COLOUR = ["Black", "White", "Grey", "Brown", "Beige", "Multicolor"]
  SIZE = ["Small", "Medium", "Big"]
  AGE = ["Puppy", "Adult"]
  pg_search_scope :global_search,
    against: %i[ name pet_type breed colour size weight ],
    associated_against: {
      user: %i[first_name last_name]
    },
    using: {
      tsearch: { prefix: true }
    }

  geocoded_by :address
  after_validation :geocode

  def adopted!
    self.update_attribute :adopted, true
  end
end
