class ApplyMessagesController < ApplicationController
  before_action do
    @apply = Apply.find(params[:apply_id])
  end
  before_action :authenticate_user_and_company

  def index
    redirect_to root_path, notice: "No Access Right." unless @apply.user == current_user || @apply.post.company == current_company
    @messages = @apply.apply_messages

    if @messages.length > 10
      @over_ten = true
      @messages = ApplyMessage.where(id: @messages[-10..-1].pluck(:id))
    end

    if params[:m]
      @over_ten = false
      @messages = @apply.apply_messages
    end

    if @messages.last && user_signed_in?
      @messages.where(user_id: nil).update_all(read: true)
    end

    if @messages.last && company_signed_in?
      @messages.where(company_id: nil).update_all(read: true)
    end

    @messages = @messages.order(:created_at)
    @message = @apply.apply_messages.build
  end

  def create
    redirect_to root_path, notice: "No Access Right." unless @apply.user == current_user || @apply.post.company == current_company
    @message = @apply.apply_messages.build(apply_message_params)
    if @message.save!
      redirect_to apply_apply_messages_path(@apply)
    else
      render 'index'
    end
  end

  private

  def authenticate_user_and_company
    if not user_signed_in? || company_signed_in?
      redirect_to root_path, notice: "You need to sign in or sign up before continuing."
    end
  end

  def apply_message_params
    params.require(:apply_message).permit(:body, :user_id, :apply_id, :company_id, :read)
  end
end
