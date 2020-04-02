class Admin::CompaniesController < ApplicationController
  before_action :set_company, only:[:show, :dashboard, :edit, :update, :destroy]
  before_action :ensure_admin_user

  PER = 10

  def new
    @company = Company.new
  end

  def create
    @company = Company.create(company_params)
    redirect_to admin_companies_path, notice: 'Created new company successfully.'
  end

  def show
  end

  def edit
  end

  def update
    if @company.update(company_params)
      redirect_to admin_companies_path, notice: "Company's account has been updated successfully."
    else
      render 'edit'
    end
  end

  def index
    @companies = Company.all.order(updated_at: "DESC").page(params[:page]).per(PER)
  end

  def dashboard
    redirect_to root_path, notice: "No Access Right." unless @company == current_company
  end

  def destroy
    @company.destroy
    redirect_to admin_companies_path, notice: "Deleted a company successfully."
  end

  private

  def set_company
    @company = Company.find_by(id: params[:id])
  end

  def company_params
    params.require(:company).permit(
      :email,
      :password,
      :password_confirmation,
      :name,
      :phone_number,
      :location,
      :address,
      :number_of_employees,
      :date_of_incorporation,
      :paid_up_capital,
      :logo,
      :logo_cache,
      :header_image,
      :header_image_cache,
      :image,
      :email_for_inquiry,
      :member_status,
      :description,
      industry_relations_attributes: [:id, :company_id,:industry_id,:_destroy],
    )
  end

end
