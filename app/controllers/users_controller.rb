class UsersController < ApplicationController
  before_action :set_user, only:[:show, :dashboard, :edit, :update, :destroy]

  before_action :authenticate_user!, only:[:dashboard, :edit, :update]
  before_action :ensure_correct_user, only:[:dashboard, :edit, :update]

  before_action :authenticate_company_without_admin_user, only:[:index]

  PER = 10

  def show
    redirect_to root_path,notice: "No Access Right." unless @user == current_user || admin_user? || company_signed_in?
  end

  def index
    @industries = Industry.all
    @job_categories = JobCategory.all
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).page(params[:page]).per(PER)
  end

  def dashboard
  end

  def edit
    if @user.educations == []
    @user.educations.build
    end

    if @user.languages == []
    @user.languages.build
    end

    if @user.desired_industries == []
    @user.desired_industries.build
    end

    if @user.work_experiences == []
    @user.work_experiences.build
    end

    if @user.user_skills == []
    @user.user_skills.build
    end

    if @user.qualifications == []
    @user.qualifications.build
    end

    if @user.desired_job_categories == []
    @user.desired_job_categories.build
    end
  end

  def update
    if @user.update(user_params)
      redirect_to dashboard_user_path, notice: 'Updated successfully.'
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
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

  def ensure_correct_user
    redirect_to root_path, notice: "No Access Right." unless @user == current_user || admin_user?
  end

  def set_user
    @user = User.find_by(id: params[:id])
  end

end
