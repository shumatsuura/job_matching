class Admin::ScoutMessagesController < ApplicationController
  before_action :ensure_admin_user

  def index
    @scout = Scout.find_by(id: params[:scout_id])
    @messages = @scout.scout_messages.order(:created_at)
  end

  def destroy
    @message = ScoutMessage.find_by(id: params[:id])
    @message.destroy
    redirect_to admin_scout_scout_messages_path(@message.scout_id), notice: "Deleted message successfully."
  end

end
