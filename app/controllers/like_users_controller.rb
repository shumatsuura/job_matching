class LikeUsersController < ApplicationController
  before_action :authenticate_company!

  def index
    @like_users = current_company.like_users
  end

  def create
    like_user = current_company.like_users.create(like_user_params)
    redirect_to user_path(like_user.user_id)
  end

  def destroy
    like_user = current_company.like_users.find_by(user_id: params[:user_id]).destroy
    redirect_to user_path(like_user.user_id)
  end

  private

  def like_user_params
    params.require(:like_user).permit(:user_id, :company_id)
  end
end
