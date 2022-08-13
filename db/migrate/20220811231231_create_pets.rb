class CreatePets < ActiveRecord::Migration[6.1]
  def change
    create_table :pets do |t|
      t.string :name
      t.string :pet_type
      t.string :breed
      t.string :colour
      t.string :size
      t.text :description
      t.float :weight

      t.timestamps
    end
  end
end
