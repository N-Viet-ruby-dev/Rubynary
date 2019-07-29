# frozen_string_literal: true

class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    auth_detail = request.env["omniauth.auth"]
    if auth_detail.info.email.split("@")[1] == "ruby-dev.jp"
      @user = User.from_omniauth(request.env["omniauth.auth"])
      if @user.persisted?
        sign_in_and_redirect @user
        flash[:success] = t "devise.omniauth_callbacks.success", kind: "Rubynary"
      else
        session["devise.google_data"] = request.env["omniauth.auth"].except(:extra)
      end
    else
      flash[:error] = t "devise.omniauth_callbacks.failure", kind: "Rubynary",
                                                             reason: "email must include @ruby-dev.jp"
      redirect_to new_user_session_path
    end
  end
end
