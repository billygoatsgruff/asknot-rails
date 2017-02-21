namespace :trends do
  desc 'Associate tweets with trends'
  task associate_tweets: :environment do
    puts 'Associating trends with tweets'

    t = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV["TWITTER_CONSUMER_KEY"]
      config.consumer_secret = ENV["TWITTER_CONSUMER_SECRET"]
    end

    twitter_trends = t.trends(1, {})

    twitter_trends.each do |twitter_trend|
      tweets = Tweet.where("full_text LIKE ?", "%#{twitter_trend.name}%")
      if tweets.size > 1
        trend = Trend.find_or_create_by(text: twitter_trend.name)
        tweets.each do |tweet|
          TrendTweet.find_or_create_by(trend_id: trend.id, tweet_id: tweet.id)
        end
      end
    end
  end
end
