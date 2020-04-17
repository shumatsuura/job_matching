class Admin::ApplyMessagesController < ApplicationController
  before_action :ensure_admin_user
  PER = 20

  def index
    @apply = Apply.find_by(id: params[:apply_id])
    @q = @apply.apply_messages.ransack(params[:q])
    @messages = @q.result(distinct: true).order(:created_at).page(params[:page]).per(PER)
  end

  def index_all
    @q = ApplyMessage.all.ransack(params[:q])
    @messages = @q.result(distinct: true).order(:created_at).page(params[:page]).per(PER)

    if params[:q]
      @check_user = params[:q][:user_id_not_in].present?
      @check_company = params[:q][:company_id_not_in].present?
    end
  end

  def destroy
    @message = ApplyMessage.find_by(id: params[:id])
    @message.destroy
    redirect_to admin_apply_apply_messages_path(@message.apply_id), notice: "Deleted message successfully."
  end
end
