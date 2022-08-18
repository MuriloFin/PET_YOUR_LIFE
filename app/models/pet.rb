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
  def adopted!
    self.update_attribute :adopted, true
  end
end
