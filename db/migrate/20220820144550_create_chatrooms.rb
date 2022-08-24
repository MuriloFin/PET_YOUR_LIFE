class CreateChatrooms < ActiveRecord::Migration[6.1]
  def change
    create_table :chatrooms do |t|
      t.string :name
      t.references :user, default: true, foreign_key: true
      t.references :pet, default: true, foreign_key: true
      t.timestamps
    end
  end
end
