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

    if @user.educations == [] or @user.educations.last.school_name != ""
    @user.educations.build
    end

    if @user.languages == [] or @user.languages.last.name != ""
    @user.languages.build
    end

    if @user.desired_industries == []
    @user.desired_industries.build
    end

    if @user.work_experiences == []
    @user.work_experiences.build
    end

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
    params.require(:user).permit(
      :first_name,
      :last_name,
      :date_of_birth,
      :gender,
      :address,
      :phone_number,
      :race,
      :religion,
      :expected_salary,
      :description,
      educations_attributes: [:id,:school_name,:major,:period_start,:period_end,:_destroy],
      languages_attributes: [:id,:name,:level,:_destroy],
      desired_industries_attributes: [:id,:user_id,:industry_id,:_destroy],
      work_experiences_attributes: [:id,:user_id,:company,:position,:salary,:description,:period_start,:period_end,:currently_employed,:_destroy]
    )
  end

  def set_user
    @user = User.find_by(id: params[:id])
  end


end
