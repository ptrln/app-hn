class CreateCommentAncestries < ActiveRecord::Migration
  def change
    create_table :comment_ancestries do |t|
      t.integer :comment_id
      t.integer :ancestor_id

      t.timestamps
    end
  end
end
