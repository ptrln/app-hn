class Post < ActiveRecord::Base
  attr_accessible :title, :url, :user_id, :comments_attributes

	belongs_to :user
	has_many :post_votes
	has_many :comments

	accepts_nested_attributes_for :comments,
		:reject_if => lambda { |attributes| attributes['body'].blank? }

	VALID_URL_REGEX = /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix

	validates :user, presence: true
	validates :title, presence: true
	validates :url, presence: true, format: { with: VALID_URL_REGEX }

	alias_method :author, :user

	scope :newest, order('created_at DESC')
	
#date(\"#{1.day.ago}\") 

	scope :top,
		joins("LEFT JOIN post_votes ON posts.id = post_votes.post_id").
		select("posts.*, SUM(CASE WHEN post_votes.created_at > #{
			Rails.env.production? ? 
				"now() - '1 day'::interval" :
				"\"#{1.day.ago}\""
			} THEN 1 ELSE 0 END) AS counts").
		group('posts.id').
		order("counts DESC, created_at DESC")

	paginates_per 20

	def has_upvoted?(user)
		post_votes.any? { |vote| vote.user_id == user.id }
	end

	def host
		url.split('/')[2]
	end

end