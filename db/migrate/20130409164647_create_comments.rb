class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :post_id, null: false
      t.integer :parent_id
      t.integer :user_id, null: false
      t.string :nesting, null: false
      t.text :body, null: false

      t.timestamps
    end
  end
end
