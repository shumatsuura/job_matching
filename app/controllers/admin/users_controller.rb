class Admin::UsersController < ApplicationController
  before_action :set_user, only:[:edit, :update, :destroy]
  before_action :ensure_admin_user

  PER = 10

  def index
    @industries = Industry.all
    @job_categories = JobCategory.all
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).page(params[:page]).per(PER)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    redirect_to admin_users_path, notice: 'Created new user successfully.'
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to dashboard_user_path(@user.id), notice: 'Updated user account successfully.'
    else
      render 'edit'
    end
  end

  def destroy
    if admin_user?
      @user.destroy
      redirect_to admin_users_path, notice: "Deleted user successfully."
    else
      redirect_to root_path, notice: "No Access Right."
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :email,
      :password,
      :password_confirmation,
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
      :status,
      :image,
      :image_cache,
      :cv,
      educations_attributes: [:id,:school_name,:major,:period_start,:period_end,:_destroy],
      languages_attributes: [:id,:name,:level,:_destroy],
      desired_industries_attributes: [:id,:user_id,:industry_id,:_destroy],
      work_experiences_attributes: [:id,:user_id,:company,:position,:salary,:description,:period_start,:period_end,:currently_employed,:_destroy],
      user_skills_attributes: [:id,:user_id,:name],
      qualifications_attributes: [:id,:name,:date_of_acquisition,:user_id],
      desired_job_categories_attributes: [:id,:user_id,:job_category_id,:_destroy],
    )
  end

  def set_user
    @user = User.find_by(id: params[:id])
  end

end
