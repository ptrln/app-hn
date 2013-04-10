class Post < ActiveRecord::Base
  attr_accessible :title, :url, :user_id, :comments_attributes
	belongs_to :user
	has_many :post_votes
	has_many :comments
	accepts_nested_attributes_for :comments,
		:reject_if => lambda { |attributes| attributes['body'].blank? }

	alias_method :author, :user

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
end

# SELECT posts.*, count(posts.id) AS count24
# FROM "posts" INNER JOIN "post_votes"
# ON "post_votes"."post_id" = "posts"."id" post_votes
# WHERE (post_votes.created_at > '2013-04-09 00:09:12.627136')
# ORDER BY count24


# SELECT posts.*, count(posts.id)
# AS counts
# FROM "posts" INNER JOIN "post_votes"
# ON "post_votes"."post_id" = "posts"."id" post_votes
# WHERE (post_votes.created_at > '2013-04-09 00:12:47.286780') ORDER BY counts

