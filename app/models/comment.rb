class Comment < ActiveRecord::Base
  attr_accessible :body, :nesting, :parent_id, :post_id, :user_id
	belongs_to :parent
	belongs_to :post
	belongs_to :user
	has_many :comment_votes
end
