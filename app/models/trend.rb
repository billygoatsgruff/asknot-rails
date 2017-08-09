class Trend < ActiveRecord::Base
  has_many :trend_tweets, dependent: :destroy
end
