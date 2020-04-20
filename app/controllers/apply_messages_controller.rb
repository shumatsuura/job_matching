class ApplyMessagesController < ApplicationController
  before_action do
    @apply = Apply.find(params[:apply_id])
  end
  before_action :authenticate_user_and_company
  before_action :authenticate_for_apply_messages

  def index
    @messages = @apply.apply_messages.order(created_at: "ASC")
    if @messages.length > 10
      @over_ten = true
      @messages = ApplyMessage.where(id: @messages[-10..-1].pluck(:id))
    end

    if params[:m]
      @over_ten = false
      @messages = @apply.apply_messages.order(created_at: "ASC")
    end

    if @messages.last && user_signed_in?
      @messages.where(user_id: nil).update_all(read: true)
    end

    if @messages.last && company_signed_in?
      @messages.where(company_id: nil).update_all(read: true)
    end

    @message = @apply.apply_messages.build
  end

  def create
    @message = @apply.apply_messages.build(apply_message_params)
    respond_to do |format|
      if @message.save!
        if @message.company_id
          Notification.create(
            target_model: "user",
            target_model_id: @apply.user_id,
            action_model: "apply_message",
            action_model_id: @message.id)
        elsif @message.user_id
          Notification.create(
            target_model: "company",
            target_model_id: @apply.post.company_id,
            action_model: "apply_message",
            action_model_id: @message.id)
        end
        format.js { render :index }
        format.html { redirect_to apply_apply_messages_path(@apply) }
      else
        format.js { render :index }
        format.html { render 'index'}
      end
    end
  end

  private

  def authenticate_for_apply_messages
    redirect_to root_path, notice: "No Access Right." unless @apply.user == current_user || @apply.post.company == current_company
  end

  def apply_message_params
    params.require(:apply_message).permit(:body, :user_id, :apply_id, :company_id, :read)
  end
end
