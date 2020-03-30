class Admin::ScoutsController < ApplicationController
  before_action :ensure_admin_user
  PER = 20

  def index
    @scouts = Scout.all.page(params[:page]).per(PER)
  end

  def create
    # scout = current_company.scouts.create(scout_params)
    # redirect_to user_path(scout.user_id), notice: "#{scout.user.first_name}さんをスカウトしました"
  end

  def destroy
    Scout.find_by(id: params[:id]).destroy
    redirect_to admin_scouts_path, notice: "Deleted scout data successfully."
  end

  private

  def scout_params
    params.require(:scout).permit(:user_id, :company_id)
  end
end
