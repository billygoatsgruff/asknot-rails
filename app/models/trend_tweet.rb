class TrendTweet < ActiveRecord::Base
  belongs_to :trend
  belongs_to :tweet
end
