class User < ActiveRecord::Base
  has_many :retweets, dependent: :destroy

  def response_hash(handle)
    {
      twitter_handle: handle,
      api_key: self.api_key
    }    
  end

  def send_push(title, message)
    if self.push_provider_id
      notification = {
        app_id: ENV["ONESIGNAL_APP_ID"],
        include_player_ids: [self.push_provider_id],
        contents: { en: title },
        subtitle: { en: message },
      }
      OneSignal::Notification.create(params: notification)
    end
  end
end
