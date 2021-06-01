ActiveAdmin.register UrlAction do

  permit_params :url, :title, :subtitle, :prompt, :action_title, :action_text, :button_text
  
  controller do
    def create
      @url_action = UrlAction.new(permitted_params[:url_action])
      @url_action.active = false unless authorized? :activate, @url_action

      if @url_action.save
        redirect_to collection_url
      else
        redirect_to :back
      end
    end
  end

  form do |f|
    f.inputs "Url Action Info" do
      f.input :url
      f.input :title
      f.input :subtitle
      f.input :prompt
      f.input :action_title
      f.input :action_text
      f.input :button_text
      f.input :active if authorized? :activate, UrlAction.new
    end

    f.actions
  end

  index do
    column :created_at
    column :url
    column :title
    column :subtitle
    column :prompt
    column :action_title
    column :action_text
    column :button_text
    column :active
    
    actions
  end
end
