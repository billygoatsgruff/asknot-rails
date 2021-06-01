require 'rails_helper'

describe 'url_actions endpoints' do
  describe 'GET /url_actions' do
    it 'returns JSON for url_actions' do
      url_action = create :url_action

      get api_v1_url_actions_url, {}, authorization_headers
      
      expect(response).to have_http_status :ok
      expect(response).to match_response_schema :url_actions
    end

    it 'returns only active url_actions' do
      url_action = create :url_action
      inactive_tweet = create :url_action, active: false

      get api_v1_url_actions_url, {}, authorization_headers
      
      expect(json['url_actions'].size).to eq 1
    end
  end
end
