class Post < ActiveRecord::Base
  attr_accessible :title, :url, :user_id, :comments_attributes
	belongs_to :user
	has_many :post_votes
	has_many :comments
	accepts_nested_attributes_for :comments

	alias_method :author, :user
end
