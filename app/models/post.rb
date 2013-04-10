class Post < ActiveRecord::Base
  attr_accessible :title, :url, :user_id, :comments_attributes

	belongs_to :user
	has_many :post_votes
	has_many :comments

	accepts_nested_attributes_for :comments,
		:reject_if => lambda { |attributes| attributes['body'].blank? }

	validates :user, presence: true
	validates :title, presence: true
	validates :url, presence: true
	validate :valid_url

	alias_method :author, :user

	scope :newest, order('created_at DESC')
	scope :top,
		joins("LEFT JOIN post_votes ON posts.id = post_votes.post_id").
		select("posts.*, SUM(CASE WHEN post_votes.created_at > \"#{1.day.ago}\" THEN 1 ELSE 0 END) AS counts").
		group('posts.id').
		order("counts DESC, created_at DESC")

	paginates_per 20

	def has_upvoted?(user)
		post_votes.any? { |vote| vote.user_id == user.id }
	end

	def host
		url.split('/')[2]
	end

	def valid_url
	  uri = URI.parse(url)
	  %w( http https ).include?(uri.scheme)
	rescue URI::BadURIError
	  false
	rescue URI::InvalidURIError
	  false
	end
end