class Retweet < ActiveRecord::Base
  belongs_to :user
  belongs_to :tweet

  validates_presence_of :tweet_id
  validates_presence_of :user_id
end
