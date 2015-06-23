class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.string :short_url, null: false
      t.integer :tag_id, null: false
      t.integer :user_id, null: false

      t.timestamps
    end

    add_index :taggings, :short_url
    add_index :taggings, :user_id
    add_index :taggings, :tag_id
  end
end
