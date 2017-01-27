class User < ActiveRecord::Base

  def response_hash
    {
      twitter_handle: self.twitter_handle,
      api_key: self.api_key
    }    
  end
end
