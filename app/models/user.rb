class User < ActiveRecord::Base

  def response_hash(handle)
    {
      twitter_handle: handle,
      api_key: self.api_key
    }    
  end
end
