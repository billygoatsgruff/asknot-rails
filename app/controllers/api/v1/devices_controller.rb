class Api::V1::DevicesController < Api::V1::ApiController

  def create
    device = Device.where(push_id: params[:device][:push_id]).first
    device = Device.create(params[:device]) unless device

    render json: device.as_json
  end

end
