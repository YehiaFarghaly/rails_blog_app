
class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    render json: {
      message: 'Logged in successfully.',
      user: user_json(resource),
      token: request.env['warden-jwt_auth.token']
    }, status: :ok
  end

  def respond_to_on_destroy
    render json: { message: 'Logged out successfully.' }, status: :ok
  end

  def user_json(user)
    return unless user
    {
      id: user.id,
      email: user.email,
      name: user.name,
      image_url: user.image.attached? ? url_for(user.image) : nil
    }
  end
end