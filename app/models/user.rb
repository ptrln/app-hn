class User < ActiveRecord::Base
	#yes, password in plain text. i know, i know. this is an one day project.
  attr_accessible :password, :screen_name, :emails_attributes
	has_many :posts
	has_many :comments
	has_many :comment_votes
	has_many :post_votes
	has_many :emails

	accepts_nested_attributes_for :emails,
		:reject_if => lambda { |attributes| attributes['email'].blank? }

	validates :password, presence: true
	validates :screen_name, presence: true, uniqueness: true

	def karma
		post_karma = Post.joins(:post_votes).where("posts.user_id = ?", self.id).count
		#comment_karma
		post_karma
	end

	def average_karma
		post_karma = Post.joins(:post_votes).where("posts.user_id = ?", self.id).count
		post_count = posts.count
		post_count == 0 ? "N/A" : post_karma / post_count
	end
end
