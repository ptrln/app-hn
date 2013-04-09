class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :screen_name, null: false
      t.string :password, null: false

      t.timestamps
    end
		add_index :users, :screen_name, unique: true
  end
end
