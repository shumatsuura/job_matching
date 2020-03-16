class ScoutsController < ApplicationController
  def create
    scout = current_company.scouts.create(user_id: params[:user_id])
    redirect_to user_path(params[:user_id]), notice: "#{scout.user.first_name}さんをスカウトしました"
  end

  def destroy
    scout = current_company.scouts.find_by(id: params[:id]).destroy
    redirect_to user_path(params[:id]), notice: "#{scout.user.first_name}さんのスカウトを削除しました。"
  end
end
