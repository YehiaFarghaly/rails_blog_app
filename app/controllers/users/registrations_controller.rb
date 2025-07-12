
class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    if resource.persisted?
      render json: {
        message: 'Signed up successfully.',
        user: user_json(resource)
      }, status: :created
    else
      render json: {
        message: 'Sign up failed.',
        errors: resource.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :image)
  end

  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation, :current_password, :name, :image)
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
