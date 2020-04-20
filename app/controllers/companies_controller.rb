class CompaniesController < ApplicationController
  before_action :set_company, only:[:show, :dashboard, :edit, :update]
  before_action :authenticate_company_without_admin_user, only:[:dashboard, :edit, :update]
  before_action :ensure_correct_company_without_admin_user, only:[:dashboard, :edit, :update]

  PER = 10

  def show
  end

  def edit
    @company.industry_relations.build if @company.industry_relations == []
  end

  def update
    if @company.update(company_params)
      redirect_to dashboard_company_path(@company.id), notice: "Updated company information successfully."
    else
      render 'edit'
    end
  end

  def index
    @industries = Industry.all
    @job_categories = JobCategory.all

    @q = Company.ransack(params[:q])
    @companies = @q.result(distinct: true).order(updated_at: "DESC").page(params[:page]).per(PER)

  end

  def dashboard
  end

  private

  def set_company
    @company = Company.find_by(id: params[:id])
  end

  def ensure_correct_company_without_admin_user
    redirect_to root_path, notice: "No Access Right." unless (@company == current_company) || (user_signed_in? && current_user.admin)
  end

  def company_params
    params.require(:company).permit(
      :name,
      :phone_number,
      :location,
      :address,
      :number_of_employees,
      :date_of_incorporation,
      :paid_up_capital,
      :logo,
      :logo_cache,
      :remove_logo,
      :header_image,
      :header_image_cache,
      :remove_header_image,
      :image,
      :email_for_inquiry,
      :member_status,
      :description,
      industry_relations_attributes: [:id, :company_id,:industry_id,:_destroy],
    )
  end
end
