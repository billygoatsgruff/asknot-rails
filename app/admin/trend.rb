ActiveAdmin.register Trend do

  permit_params :twitter_handle

  controller do
    def create
      @trend = Trend.new(permitted_params[:trend])

      if @trend.save
        redirect_to collection_url
      else
        redirect_to :back
      end
    end
  end

  form do |f|
    f.inputs "Trend Info" do
      f.input :text
    end
    f.actions
  end

  index do
    column :id
    column :text
    column :created_at
    actions
  end
end