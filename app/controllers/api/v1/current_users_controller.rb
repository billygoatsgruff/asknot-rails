class Api::V1::CurrentUsersController < ApiController
  def show
    user = User.find(current_user['id'])

    render json: user,
           root: :user,
           serializer: UserSerializer
  end

  def update
    if current_user.update(user_params)

      render json: current_user,
             serializer: UserSerializer,
             root: :user
    else
      render_errors(current_user)
    end
  end

  private

  def user_params
    params.require(:user).
      permit(:has_shared, :is_supporter)
  end
end
