require 'rails_helper'

describe 'retweets endpoints' do
  describe 'POST /retweets' do
    it 'returns :created for retweet' do
      tweet = create(:tweet)

      post(api_v1_retweets_url, { tweet_id: tweet.id }.to_json, authorization_headers)
      
      expect(response).to have_http_status :created
    end

    it 'returns :not_found for non existant tweet' do
      post(api_v1_retweets_url, {  }.to_json, authorization_headers)
      
      expect(response).to have_http_status :not_found
    end
  end

  describe 'DELETE /retweets' do
    it 'returns :ok for retweet' do
      user = create(:user)
      tweet = create(:tweet)
      create(:retweet, tweet_id: tweet.id, user_id: user.id)

      delete(api_v1_retweet_url(tweet), {  }.to_json, authorization_headers(user))
      
      expect(response).to have_http_status :ok
    end

    it 'returns :not_found for non existant retweet' do
      tweet = create(:tweet)

      delete(api_v1_retweet_url(tweet), {  }.to_json, authorization_headers)
      
      expect(response).to have_http_status :not_found
    end
  end
end
