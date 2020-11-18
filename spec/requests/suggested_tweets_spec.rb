require 'rails_helper'

describe 'suggested tweets endpoints' do
  describe 'POST /suggested_tweets' do
    it 'returns :created for suggested_tweets' do
      tweet = create(:tweet)
      allow_any_instance_of(Twitter::REST::Client).to receive(:status).and_return(Twitter::Tweet.new(id: 1, text: "test"))

      post(api_v1_suggested_tweets_url, { twitter_id: tweet.twitter_id }.to_json, authorization_headers)
      
      expect(response).to have_http_status :created
      expect(SuggestedTweet.count).to eq 1
    end

    it 'returns :not_found for non existant tweet' do
      allow_any_instance_of(Twitter::REST::Client).to receive(:status).and_return(Twitter::Tweet.new(id: 1, text: nil))
      post(api_v1_suggested_tweets_url, {  }.to_json, authorization_headers)
      
      expect(response).to have_http_status :not_found
    end
  end
end
