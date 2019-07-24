# frozen_string_literal: true

class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    auth_detail = request.env["omniauth.auth"]

    if auth_detail.info["email"].split("@")[1] == "ruby-dev.jp"
      @user = User.from_omniauth(request.env["omniauth.auth"])
      if @user.persisted?
        sign_in_and_redirect @user
        flash[:notice] = I18n.t "devise.omniauth_callbacks.success", kind: "Google"
      else
        session["devise.google_data"] = request.env["omniauth.auth"].except(:extra)
        flash[:error] = t(".signin_uns")
      end
    else
      flash[:error] = t(".dont_access")
      redirect_to new_user_session_path
    end
  end
end
