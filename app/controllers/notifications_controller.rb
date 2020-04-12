class NotificationsController < ApplicationController

  def index
    @notifications = Notification.where(target_model: "user", target_model_id: current_user.id).order(created_at: "DESC") if user_signed_in?
    @notifications = Notification.where(target_model: "company", target_model_id: current_company.id).order(created_at: "DESC") if company_signed_in?
  end

  def change_to_read
    @notifications = Notification.where(target_model: "user", target_model_id: current_user.id) if user_signed_in?
    @notifications = Notification.where(target_model: "company", target_model_id: current_company.id) if company_signed_in?
    @notifications.update_all(read: true)
    redirect_to notifications_path
  end

  def show
    notification = Notification.find_by(id: params[:id])
    notification.read = true
    notification.save
    redirect_to notification.url
  end

end
