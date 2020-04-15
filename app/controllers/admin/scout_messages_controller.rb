class Admin::ScoutMessagesController < ApplicationController
  before_action :ensure_admin_user
  PER = 20

  def index
    @scout = Scout.find_by(id: params[:scout_id])
    @q = @scout.scout_messages.ransack(params[:q])
    @messages = @q.result(distinct: true).order(:created_at).page(params[:page]).per(PER)
  end

  def index_all
    @q = ScoutMessage.all.ransack(params[:q])
    @messages = @q.result(distinct: true).order(:created_at).page(params[:page]).per(PER)

    if params[:q]
      @check_user = params[:q][:user_id_not_in].present?
      @check_company = params[:q][:company_id_not_in].present?
    end
  end

  def destroy
    @message = ScoutMessage.find_by(id: params[:id])
    @message.destroy
    redirect_to admin_scout_scout_messages_path(@message.scout_id), notice: "Deleted message successfully."
  end

end
