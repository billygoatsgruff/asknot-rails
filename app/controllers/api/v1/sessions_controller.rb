require 'digest'

class Api::V1::SessionsController < ApiController
  skip_before_filter :authenticate!

  def create
    t = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV["TWITTER_CONSUMER_KEY"]
      config.consumer_secret = ENV["TWITTER_CONSUMER_SECRET"]
      config.access_token = params[:access_token]
      config.access_token_secret = params[:access_token_secret]
    end

    response = t.verify_credentials

    if response.class == Twitter::User
      twitter_handle = Digest::SHA256.hexdigest response.screen_name.downcase

      user = User.find_by(twitter_handle: "#{twitter_handle}")
      user = User.create(twitter_handle: "#{twitter_handle}", api_key: SecureRandom.uuid) unless user
      
      render json: user.response_hash(response.screen_name), status: :ok
    else
      head :unauthorized
    end
  end
end
