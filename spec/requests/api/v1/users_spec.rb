require 'rails_helper'

describe 'users endpoints' do
  describe 'GET /users/:id' do
    it 'returns JSON for trends' do
      user = create(:user)
      tweet = create(:tweet)

      retweet = create(:retweet, tweet_id: tweet.id, user_id: user.id, created_at: 1.hour.ago)

      trend = create(:trend, text: "#hashtag")
      trend_tweet = create(:trend_tweet, tweet_id: tweet.id, trend_id: trend.id)

      get(api_v1_user_url(user), {}, authorization_headers)

      expect(response).to have_http_status :ok
      expect(response).to match_response_schema :trends
    end

    it 'returns only trends created after user retweet' do
      user = create(:user)
      tweet = create(:tweet)
      trend = create(:trend, text: "#hashtag")
      trend_tweet = create(:trend_tweet, tweet_id: tweet.id, trend_id: trend.id)

      retweet = create(:retweet, tweet_id: tweet.id, user_id: user.id, created_at: 1.hour.ago)

      irrelevant_trend = create(:trend, text: "#AnotherHashtag", created_at: 1.hour.ago)
      irrelevant_tweet = create(:tweet, full_text: "Tweeting #AnotherHashtag")
      irrelevant_trend_tweet = create(:trend_tweet, tweet_id: irrelevant_tweet.id, trend_id: irrelevant_trend.id)
      irrelevant_retweet = create(:retweet, tweet_id: irrelevant_tweet.id, user_id: user.id)

      get(api_v1_user_url(user), {}, authorization_headers)

      expect(json['trends'].size).to eq 1
    end

    it 'returns only user trends' do
      user = create(:user)
      tweet = create(:tweet)
      retweet = create(:retweet, tweet_id: tweet.id, user_id: user.id, created_at: 1.hour.ago)
      trend = create(:trend, text: "#hashtag")
      trend_tweet = create(:trend_tweet, tweet_id: tweet.id, trend_id: trend.id)

      irrelevant_tweet = create(:tweet, full_text: "Tweeting #AnotherHashtag")
      irrelevant_user = create(:user)
      irrelevant_retweet = create(:retweet, tweet_id: irrelevant_tweet.id, user_id: irrelevant_user.id)
      irrelevant_trend = create(:trend, text: "#AnotherHashtag")
      irrelevant_trend_tweet = create(:trend_tweet, tweet_id: irrelevant_tweet.id, trend_id: irrelevant_trend.id)

      get(api_v1_user_url(user), {}, authorization_headers)

      expect(json['trends'].size).to eq 1
    end

    it 'returns only one trend instance' do
      user = create(:user)
      tweet = create(:tweet)
      retweet = create(:retweet, tweet_id: tweet.id, user_id: user.id)
      trend = create(:trend, text: "#hashtag")
      trend_tweet = create(:trend_tweet, tweet_id: tweet.id, trend_id: trend.id)

      irrelevant_tweet = create(:tweet, full_text: "Tweeting #hashtag")
      irrelevant_retweet = create(:retweet, tweet_id: irrelevant_tweet.id, user_id: user.id)
      irrelevant_trend_tweet = create(:trend_tweet, tweet_id: irrelevant_tweet.id, trend_id: trend.id)

      get(api_v1_user_url(user), {}, authorization_headers)

      expect(json['trends'].size).to eq 1
    end

    it 'returns only trends the user has retweeted' do
      user = create(:user)
      tweet = create(:tweet)
      retweet = create(:retweet, tweet_id: tweet.id, user_id: user.id)
      trend = create(:trend, text: "#hashtag")
      trend_tweet = create(:trend_tweet, tweet_id: tweet.id, trend_id: trend.id)

      irrelevant_tweet = create(:tweet, full_text: "Tweeting #AnotherHashtag")
      irrelevant_trend_tweet = create(:trend_tweet, tweet_id: irrelevant_tweet.id, trend_id: trend.id)
      irrelevant_trend = create(:trend, text: "#AnotherHashtag")
      irrelevant_trend_tweet = create(:trend_tweet, tweet_id: irrelevant_tweet.id, trend_id: irrelevant_trend.id)

      get(api_v1_user_url(user), {}, authorization_headers)

      expect(json['trends'].size).to eq 1
    end
  end
end
