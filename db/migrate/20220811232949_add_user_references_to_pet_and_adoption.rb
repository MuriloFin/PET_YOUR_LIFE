class AddUserReferencesToPetAndAdoption < ActiveRecord::Migration[6.1]
  def change
    add_reference :pets, :user, foreign_key: true
    add_reference :adoptions, :user, foreign_key: true
  end
end
