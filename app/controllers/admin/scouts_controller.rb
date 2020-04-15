class Admin::ScoutsController < ApplicationController
  before_action :ensure_admin_user
  PER = 20

  def index
    @q = Scout.ransack(params[:q])
    @scouts = @q.result(distinct: true).page(params[:page]).per(PER)
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
