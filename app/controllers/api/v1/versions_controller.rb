class Api::V1::VersionsController < ApiController
  skip_before_filter :authenticate!
  
  def show
    version = ENV.fetch('APP_VERSION')

    render json: { version: version }
  end
end
