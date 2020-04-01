class ApplicationController < ActionController::Base
  

  private

  def authenticate_user_and_company
    if not user_signed_in? || company_signed_in?
      redirect_to root_path, notice: "You need to sign in or sign up before continuing."
    end
  end

  def admin_user?
    if user_signed_in? && current_user.admin
      true
    else
      false
    end
  end

  def ensure_admin_user
    redirect_to root_path, notice: "No Access Right." unless admin_user?
  end

  def authenticate_company_without_admin_user
    if not admin_user?
      authenticate_company!
    end
  end
end
