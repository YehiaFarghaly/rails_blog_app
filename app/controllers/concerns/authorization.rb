module Authorization
  extend ActiveSupport::Concern

  def authorize_owner!(resource, message: 'You are not authorized to perform this action.')
    unless resource.user == current_user
      render json: { error: message }, status: :forbidden
    end
  end
end
