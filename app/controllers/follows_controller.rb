class FollowsController < ApplicationController
  before_action :authenticate_user_and_company

  def index
    @follows = company_signed_in? ? current_company.follows : current_user.follows
  end

  def create
    follow = current_user.follows.create(follow_params)
    redirect_to company_path(follow.company_id)
  end

  def destroy
    follow = current_user.follows.find_by(company_id: params[:company_id]).destroy
    redirect_to company_path(follow.company_id)
  end

  private

  def authenticate_user_and_company
    if not user_signed_in? || company_signed_in?
      redirect_to root_path, notice: "You need to sign in or sign up before continuing."
    end
  end

  def follow_params
    params.require(:follow).permit(:user_id, :company_id)
  end

end
