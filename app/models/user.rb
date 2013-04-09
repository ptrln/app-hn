class User < ActiveRecord::Base
  attr_accessible :password, :screen_name, :emails_attributes
	has_many :posts
	has_many :comments
	has_many :comment_votes
	has_many :post_votes
	has_many :emails
	accepts_nested_attributes_for :emails
end
