ActiveAdmin.register Tweet do

  permit_params :twitter_id, :why, :active
  
  controller do
    def create
      @tweet = Tweet.new(permitted_params[:tweet])
      @tweet.active = false unless authorized? :activate, @tweet

      if @tweet.save
        redirect_to collection_url
      else
        redirect_to :back
      end
    end
  end

  form do |f|
    f.inputs "Tweet Info" do
      f.input :twitter_id
      f.input :why
      f.input :active if authorized? :activate, Tweet.new
    end

    f.actions
  end

  index do
    column :created_at
    column :twitter_id
    column :active
    column :why
    column :full_text
    
    actions
  end
end