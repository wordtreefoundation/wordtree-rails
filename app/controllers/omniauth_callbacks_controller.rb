class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    p env["omniauth.auth"]
  end

  def github
  end

  def facebook
    p env["omniauth.auth"]
    @user = User.find_for_facebook_oauth(env["omniauth.auth"], current_user)

    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.facebook_data"] = env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end
