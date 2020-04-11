class ApplicationController < ActionController::Base
  before_action :basic, if: :production?

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

  def production?
    Rails.env.production?
  end
  
  def basic
    authenticate_or_request_with_http_basic('BA') do |name, password|
      name == ENV['BASIC_AUTH_NAME'] && password == ENV['BASIC_AUTH_PASSWORD']
    end
  end
end
