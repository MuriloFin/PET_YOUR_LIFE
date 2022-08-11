class CreateAdoptions < ActiveRecord::Migration[6.1]
  def change
    create_table :adoptions do |t|
      t.references :pet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
