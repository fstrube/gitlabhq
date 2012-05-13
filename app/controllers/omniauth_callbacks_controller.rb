class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_filter :verify_authenticity_token

  def google_apps
    info = request.env["omniauth.auth"]["info"]
    @user = User.find_for_googleapps_oauth(info)
    if @user.persisted?
      @user.remember_me = true
    end
    sign_in_and_redirect @user
  end
 
  def ldap
    # We only find ourselves here if the authentication to LDAP was successful.
    info = request.env["omniauth.auth"]["info"]
    @user = User.find_for_ldap_auth(info)
    if @user.persisted?
      @user.remember_me = true
    end
    sign_in_and_redirect @user
  end

end
