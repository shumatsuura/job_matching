class UsersController < ApplicationController
  before_action :set_user, only:[:show, :dashboard, :edit, :update]

  def show
    # @user = User.find_by(id: params[:id])
  end

  def index
  end

  def dashboard
    # @user = User.find_by(id: params[:id])
  end

  def edit

  end

  def update
    if @user.update(user_params)
      redirect_to dashboard_user_path
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name,
                                 :last_name,
                                 :date_of_birth,
                                 :gender,
                                 :address,
                                 :phone_number,
                                 :race,
                                 :religion,
                                 :expected_salary,
                                 :description
                               )
  end

  def set_user
    @user = User.find_by(id: params[:id])
  end


end
