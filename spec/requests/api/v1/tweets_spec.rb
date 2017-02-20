require 'rails_helper'

describe 'tweets endpoints' do
  describe 'GET /tweets' do
    it 'returns JSON for tweets' do
      tweet = create(:tweet)

      get(api_v1_tweets_url, {}, authorization_headers)
      
      expect(response).to have_http_status :ok
      expect(response).to match_response_schema :tweets
    end

    it 'returns only active tweets' do
      tweet = create(:tweet)
      inactive_tweet = create(:tweet, active: false)

      get(api_v1_tweets_url, {}, authorization_headers)
      
      expect(json['tweets'].size).to eq 1
    end
  end
end
