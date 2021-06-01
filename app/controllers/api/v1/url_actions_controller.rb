class Api::V1::UrlActionsController < ApiController
  def index
    url_actions = UrlAction.all.where(active: true).order(created_at: :desc)
    paginate json: url_actions, each_serializer: UrlActionSerializer
  end
end
