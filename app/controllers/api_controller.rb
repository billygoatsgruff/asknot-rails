class ApiController < ApplicationController
  before_filter :authenticate!
  protect_from_forgery with: :null_session

  class NotEnoughParametersProvided < StandardError
    def message
      I18n.t('errors.not_enough_parameters_provided')
    end
  end

  def per_page
    if params[:per_page].present?
      params[:per_page].to_i
    elsif items_per_page.present?
      items_per_page.to_i
    else
      default_per_page.to_i
    end
  end

  def items_per_page
    default_per_page
  end

  def default_per_page
    ENV.fetch('PER_PAGE', 20)
  end

  def authenticate!
    @current_user = User.find_by(api_key: request.headers["X-Api-Key"])
    if @current_user.blank?
      head :unauthorized
    end
  end

  def render_errors(model, status = :unprocessable_entity)
    render json: { errors: model.errors.full_messages },
           status: status
  end

  rescue_from NotEnoughParametersProvided do |exception|
    render json: { errors: exception.message }, status: :bad_request
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { errors: exception.message }, status: :not_found
  end
end
