class Device < ActiveRecord::Base
  belongs_to :user

  validates :push_id, :presence => true, :uniqueness => true

  after_save :register

  def as_json(options={})
    included = options[:include] || {}
    except = [:user].delete_if { |attr| included.include?(attr) }

    hash = super(:except => except)
    hash['errors'] = errors.as_json if errors.present?

    hash
  end

  private

  def register
    response = OneSignal::Player.create(params: device_params)
    player_id = JSON.parse(response.body)["id"]

    if !self.user.push_provider_id
      self.user.push_provider_id = player_id
      self.user.save
    end
  end

  def device_params
    params = {
      app_id: "87e83ea0-400a-4ca4-a8fd-8e25aea016d4",
      identifier: self.push_id,
      device_type: device_type
    }

    if self.user.push_provider_id
      params[:tags] = { user_id: self.user.push_provider_id }
    end

    params
  end

  def device_type
    self.platform == "android" ? 1 : 0
  end
end
