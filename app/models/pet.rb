class Pet < ApplicationRecord
  belongs_to :user
  has_one_attached :photo
  has_many :adoptions, dependent: :destroy
  has_many :chatrooms, dependent: :destroy
  has_many :likes
  validate :name, :pet_type, :breed, :colour, :size, :weight, :age
  include PgSearch::Model
  PET_TYPE = ["Cachorro", "Gato"]
  DOG_BREED = ["Sem Raça Definida", "Basset", "Beagle", "Border Collie", "Bulldog Francês", "Dachsund", "Golden Retriever", "Jack Russell", "Labrador", "Lhasa Apso", "Maltês", "Pastor Alemão", "Pinscher", "Pitbull", "Pomerânia (Spitz Alemão)", "Poodle", "Pug", "Rottweiler", "Shih Tzu", "Yorkshire Terrier"]
  CAT_BREED = ["Sem Raça Definida", "Angorá", "Bengal", "British Shorthair", "Burmese", "Maine Coon", "Persa", "Ragdoll", "Siamês", "Siberiano", "Sphynx"]
  COLOUR = ["Abricot", "Bege", "Branco", "Cinza", "Dourado", "Marrom", "Multicolor", "Preto", "Ruivo"]
  SIZE = ["Pequeno", "Médio", "Grande"]
  AGE = ["Filhote", "Adulto"]
  GENDER = ["Fêmea", "Macho"]
  pg_search_scope :global_search,
    against: %i[ name pet_type breed colour size age ],
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
