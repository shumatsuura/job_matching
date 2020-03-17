class AppliesController < ApplicationController
  before_action :authenticate_user_and_company

  def index
    @applies = company_signed_in? ? current_company.company_applies : current_user.applies
  end

  def create
    apply = current_user.applies.create(apply_params)
    redirect_to post_path(apply.post_id)
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
    params.require(:apply).permit(:user_id, :post_id)
  end
end
