class CommentAncestry < ActiveRecord::Base
  attr_accessible :ancestor_id, :comment_id
	belongs_to :comment
	belongs_to :ancestor, class_name: "Comment"
end
