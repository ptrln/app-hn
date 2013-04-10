class User < ActiveRecord::Base
  attr_accessible :password, :screen_name, :emails_attributes
	has_many :posts
	has_many :comments
	has_many :comment_votes
	has_many :post_votes
	has_many :emails
	accepts_nested_attributes_for :emails,
		:reject_if => lambda { |attributes| attributes['email'].blank? }

	def karma
		post_karma = Post.joins(:post_votes).where("posts.user_id = ?", self.id).count

		post_karma
	end
end
