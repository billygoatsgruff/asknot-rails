class User < ActiveRecord::Base

  def response_hash
    {
      twitter_handle: user.twitter_handle,
      api_key: user.api_key
    }    
  end
end
