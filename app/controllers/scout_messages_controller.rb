class ScoutMessagesController < ApplicationController
  before_action do
    @scout = Scout.find(params[:scout_id])
  end
  before_action :authenticate_user_and_company
  before_action :authenticate_for_scout_messages

  def index
    @messages = @scout.scout_messages
    if @messages.length > 10
      @over_ten = true
      @messages = ScoutMessage.where(id: @messages[-10..-1].pluck(:id))
    end

    if params[:m]
      @over_ten = false
      @messages = @scout.scout_messages
    end

    if @messages.last && user_signed_in?
      @messages.where(user_id: nil).update_all(read: true)
    end

    if @messages.last && company_signed_in?
      @messages.where(company_id: nil).update_all(read: true)
    end

    @messages = @messages.order(:created_at)
    @message = @scout.scout_messages.build
  end

  def create
    @message = @scout.scout_messages.build(scout_message_params)
    if @message.save!
      redirect_to scout_scout_messages_path(@scout)
    else
      render 'index'
    end
  end

  private

  def authenticate_for_scout_messages
    redirect_to root_path, notice: "No Access Right." unless @scout.user == current_user || @scout.company == current_company
  end

  def scout_message_params
    params.require(:scout_message).permit(:body, :user_id, :company_id, :read)
  end
end
