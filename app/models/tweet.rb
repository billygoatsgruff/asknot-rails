class Tweet < ActiveRecord::Base
  validates :full_text, presence: true

  has_many :retweets, dependent: :destroy
  has_many :trend_tweets, dependent: :destroy

  before_validation :fetch_text

  private 

  def fetch_text
    if self.full_text == nil
      t = Twitter::REST::Client.new do |config|
        config.consumer_key = ENV["TWITTER_CONSUMER_KEY"]
        config.consumer_secret = ENV["TWITTER_CONSUMER_SECRET"]
      end
      
      response = t.status(self.twitter_id)

      if response.class == Twitter::Tweet
        self.full_text = response.text
      end
    end
  end
end
