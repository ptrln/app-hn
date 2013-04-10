class Comment < ActiveRecord::Base
  attr_accessible :body, :nesting, :parent_id, :post_id, :user_id

	belongs_to :parent
	belongs_to :post
	belongs_to :user
	has_many :comment_votes
	has_many :comments, foreign_key: "parent_id"	#direct_children
	has_many :comment_ancestries #ancestors
	has_many :parent_comments, :through => :comment_ancestries, :source => "ancestor"
	has_many :comment_children, foreign_key: "ancestor_id", class_name: "CommentAncestry"
	has_many :child_comments, :through => :comment_children, :source => "comment"

	default_scope order('nesting')

	scope :newest, order('created_at DESC')

	validates :body, presence: true

	def nesting_level
		nesting.split('|').count - 2
	end
end
