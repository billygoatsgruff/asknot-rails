class Api::V1::SuggestedTweetsController < ApiController
  def create
    suggested = SuggestedTweet.new(twitter_id: params[:twitter_id], user_id: @current_user.id)

    if suggested.save
      head :created
    else
      head :not_found
    end
  end
end
