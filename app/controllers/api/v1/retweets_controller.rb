class Api::V1::RetweetsController < Api::V1::ApiController
  def create
    retweet = Retweet.new(tweet_id: params[:tweet_id], user_id: @current_user.id)

    if retweet.save
      head :created
    else
      head :not_found
    end
  end
end
