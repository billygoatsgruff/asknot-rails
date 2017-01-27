class API::V1::SessionsController < ApiController
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
      user = User.find_by(twitter_handle: "#{response.screen_name.downcase}")
      user = User.create(twitter_handle: "#{response.screen_name.downcase}", api_key: SecureRandom.base64) unless user
      
      render json: user.response_hash, status: :ok
    else
      head :unauthorized
    end
  end
end
