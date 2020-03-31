class Admin::AppliesController < ApplicationController
  before_action :ensure_admin_user
  PER = 20

  def index
    @applies = Apply.all.page(params[:page]).per(PER)
  end

  def destroy
    Apply.find_by(id: params[:id]).destroy
    redirect_to admin_applies_path, notice: "Deleted apply data successfully."
  end

  private

  def apply_params
    params.require(:apply).permit(:user_id, :post_id)
  end
end
