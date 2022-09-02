class AddGenderAndAgeToPets < ActiveRecord::Migration[6.1]

  def up
    add_column :pets, :age, :string
    add_column :pets, :gender, :string
    Pet.update_all(gender: "Male", age: "Adult")
  end

  def down
    remove_column :pets, :age, :string
    remove_column :pets, :gender, :string
  end
end
