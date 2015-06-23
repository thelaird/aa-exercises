class CreateSubs < ActiveRecord::Migration
  def change
    create_table :subs do |t|
      t.integer :moderator_id, null: false
      t.string :title, null: false
      t.text :description

      t.timestamps
    end

    add_index :users, :username, unique: true
    add_index :subs, :moderator_id
    add_index :subs, :title
  end
end
