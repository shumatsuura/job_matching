class AppliesController < ApplicationController
  before_action :authenticate_user_and_company

  def index
    @applies = company_signed_in? ? current_company.company_applies.order(updated_at: "DESC") : current_user.applies.order(updated_at: "DESC")
  end

  def update
    @apply = Apply.find_by(id: params[:id])
    @apply.update(apply_params)
    redirect_to applies_path
  end

  def create
    if current_user.first_name.present?
    apply = current_user.applies.create(apply_params)
    notification = Notification.create(
      target_model: "company",
      target_model_id: apply.post.company_id,
      action_model: "apply",
      action_model_id: apply.id)
    notification.message = notification.create_message
    notification.save
    redirect_to post_path(apply.post_id), notice: "Applied successfully."
    else
      redirect_to dashboard_user_path(current_user.id), alert: "Please enter basic profile before applying."
    end
  end

  def destroy
    current_user.applies.find_by(post_id: params[:post_id]).destroy
    redirect_to post_path(params[:post_id])
  end

  private

  def authenticate_user_and_company
    if not user_signed_in? || company_signed_in?
      redirect_to root_path, notice: "You need to sign in or sign up before continuing."
    end
  end

  def apply_params
    params.require(:apply).permit(:user_id, :post_id,:status)
  end
end
