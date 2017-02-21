namespace :trends do
  desc 'Associate tweets with trends'
  task associate_tweets: :environment do
    puts 'Associating trends with tweets'

    t = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV["TWITTER_CONSUMER_KEY"]
      config.consumer_secret = ENV["TWITTER_CONSUMER_SECRET"]
    end

    twitter_trends = t.trends(2514815, {})
    twitter_trends = twitter_trends.map &:name

    twitter_trends.each do |twitter_trend|
      tweets = Tweet.where("LOWER(full_text) LIKE ?", "%#{twitter_trend.downcase}%")
      puts "#{twitter_trend}: #{tweets.size}"
      if tweets.size > 0
        trend = Trend.find_or_create_by(text: twitter_trend)
        tweets.each do |tweet|
          TrendTweet.find_or_create_by(trend_id: trend.id, tweet_id: tweet.id)
        end
      end
    end
  end
end
