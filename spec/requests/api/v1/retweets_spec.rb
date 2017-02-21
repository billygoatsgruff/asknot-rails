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
end
