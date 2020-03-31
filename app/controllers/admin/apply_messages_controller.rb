class Admin::ApplyMessagesController < ApplicationController
  before_action :ensure_admin_user
  PER = 20

  def index
    @apply = Apply.find_by(id: params[:apply_id])
    @messages = @apply.apply_messages.order(:created_at).page(params[:page]).per(PER)
  end

  def index_all
    @messages = ApplyMessage.all.order(:created_at).page(params[:page]).per(PER)
  end

  def destroy
    @message = ApplyMessage.find_by(id: params[:id])
    @message.destroy
    redirect_to admin_apply_apply_messages_path(@message.apply_id), notice: "Deleted message successfully."
  end
end
