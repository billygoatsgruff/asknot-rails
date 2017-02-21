class Api::V1::TweetsController < ApiController
  def index
    tweets = Tweet.all.where(active: true).order(created_at: :desc)
    paginate json: tweets, each_serializer: TweetIndexSerializer
  end
end
