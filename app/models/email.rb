class Email < ActiveRecord::Base
  attr_accessible :email, :user_id
	belongs_to :user

  VALID_EMAIL_REGEX = /^([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})$/i

  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  validates :user, presence: true
end
