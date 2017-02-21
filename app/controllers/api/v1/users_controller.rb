class Api::V1::UsersController < ApiController
  def show
    render json: response_hash, each_serializer: TrendIndexSerializer
  end

  private

  def response_hash
    { trends: trends }
  end

  def trends
    Trend.find_by_sql([query, @current_user.id])
  end

  def query 
    'SELECT trends.id,trends.text FROM trends ' \
    'INNER JOIN trend_tweets ON trend_tweets.trend_id = trends.id ' \
    'INNER JOIN tweets ON tweets.id = trend_tweets.tweet_id ' \
    'INNER JOIN retweets ON retweets.tweet_id = tweets.id ' \
    'WHERE retweets.user_id = ? AND retweets.created_at < trends.created_at ' \
    'GROUP BY trends.id'
  end
end
