ActiveAdmin.register Tweet do

  permit_params :twitter_id
  
  controller do
    def create
      @tweet = Tweet.new(permitted_params[:tweet])

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
    end

    f.actions
  end

  index do
    column :id
    column :twitter_id
    column :created_at
  end
end