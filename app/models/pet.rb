class Pet < ApplicationRecord
  belongs_to :user
  has_one_attached :photo
  has_many :adoptions, dependent: :destroy
  validate :name, :pet_type, :breed, :colour, :size, :weight
  include PgSearch::Model
  pg_search_scope :global_search,
    against: %i[ name pet_type breed colour size weight ],
    associated_against: {
      user: %i[first_name last_name]
    },
    using: {
      tsearch: { prefix: true }
    }
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
