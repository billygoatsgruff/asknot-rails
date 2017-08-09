class User < ActiveRecord::Base
  has_many :retweets, dependent: :destroy

  def response_hash(handle)
    {
      twitter_handle: handle,
      api_key: self.api_key
    }    
  end
end
