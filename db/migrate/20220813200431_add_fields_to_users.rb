class AddFieldsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :cpf, :string
    add_column :users, :telephone, :string
    add_column :users, :address, :string
  end
end
