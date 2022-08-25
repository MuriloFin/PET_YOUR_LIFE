class AddGenderAndAgeToPets < ActiveRecord::Migration[6.1]
  def change
    add_column :pets, :age, :string
    add_column :pets, :gender, :boolean
  end
end
