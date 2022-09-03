class CreateLikes < ActiveRecord::Migration[6.1]
  def self.up
    create_table :likes do |t|
      t.integer :pet_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :likes
  end
end
