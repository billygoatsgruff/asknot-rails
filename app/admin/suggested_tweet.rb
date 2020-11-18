ActiveAdmin.register SuggestedTweet do

  permit_params :twitter_id
  
  controller do
    def create
      @tweet = SuggestedTweet.new(permitted_params[:tweet])
      @tweet.active = false unless authorized? :activate, @tweet

      if @tweet.save
        redirect_to collection_url
      else
        redirect_to :back
      end
    end
  end

  form do |f|
    f.inputs "SuggestedTweet Info" do
      f.input :twitter_id
    end

    f.actions
  end

  index do
    column :created_at
    column :twitter_id
    column :user_id
    column :full_text
    
    actions
  end
end
