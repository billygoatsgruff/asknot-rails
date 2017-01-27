ActiveAdmin.register User do

  permit_params :twitter_handle

  controller do
    def create
      @user = User.new(permitted_params[:user])
      @user.api_key = SecureRandom.base64

      if @user.save
        redirect_to collection_url
      else
        redirect_to :back
      end
    end
  end

  form do |f|
    f.inputs "User Info" do
      f.input :twitter_handle
      f.input :api_key
    end
    f.actions
  end

  index do
    column :id
    column :twitter_handle
    column :api_key
    column :created_at
  end
end