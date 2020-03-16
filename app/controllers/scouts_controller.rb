class ScoutsController < ApplicationController
  before_action :authenticate_user_and_company

  def index
    @scouts = company_signed_in? ? current_company.scouts : current_user.scouts
  end

  def create
    scout = current_company.scouts.create(scout_params)
    redirect_to user_path(scout.user_id), notice: "#{scout.user.first_name}さんをスカウトしました"
  end

  def destroy
    scout = current_company.scouts.find_by(user_id: params[:user_id]).destroy
    redirect_to user_path(params[:user_id]), notice: "#{scout.user.first_name}さんのスカウトを解除しました。"
  end

  private

  def authenticate_user_and_company
    if not user_signed_in? || company_signed_in?
      redirect_to root_path,notice: "You need to sign in or sign up before continuing."
    end
  end

  def scout_params
    params.require(:scout).permit(:user_id, :company_id)
  end
end
