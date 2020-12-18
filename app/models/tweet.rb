class Tweet < ApplicationRecord
	belongs_to :user
  has_many :retweets
  has_many :comments

  def self.search query
    ids = Tweet.where("lower(name) LIKE lower(?)", "%#{query}%").ids
    ids = Tweet.includes(:user).where("lower(users.name) LIKE lower(?)", "%#{query}%").reference(:user).ids
    ids = Tweet.all.ids if query.include?("all")
    return Tweet.find(ids)
  end
end
