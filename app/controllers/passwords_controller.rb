class PasswordsController < Devise::PasswordsController
  def create
    self.resource = resource_class.find_by(email: resource_params[:email])

    if resource.present?
      super
    else
      flash[:alert] = "そのメールアドレスはまだ登録されていないようです。"
      redirect_to new_user_password_path
    end
  end
end
