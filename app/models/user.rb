class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable



  has_many :tweets, :dependent => :destroy

  # Will return an array of follows for the given user instance
  has_many :received_follows, foreign_key: :followed_user_id, class_name: "Follow"

  # Will return an array of users who follow the user instance
  has_many :followers, through: :received_follows, source: :follower

  #####################

  # returns an array of follows a user gave to someone else
  has_many :given_follows, foreign_key: :follower_id, class_name: "Follow"

  # returns an array of other users who the user has followed
  has_many :followings, through: :given_follows, source: :followed_user

  scope :all_except, ->(user) { where.not(id: user) }

  def self.check_following?(current_user_id,check_user_id)
    Follow.where(follower_id: current_user_id, followed_user_id: check_user_id).present?
  end

  def username
    self.name
  end
  
end
