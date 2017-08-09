class Retweet < ActiveRecord::Base
  belongs_to :user, counter_cache: true
  belongs_to :tweet, counter_cache: true

  validates_presence_of :tweet_id
  validates_presence_of :user_id
end
