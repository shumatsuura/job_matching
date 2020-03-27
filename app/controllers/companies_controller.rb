class CompaniesController < ApplicationController
  before_action :set_company, only:[:show, :dashboard, :edit, :update]
  before_action :authenticate_company!, only:[:dashboard, :edit, :update]

  PER = 10

  def show
  end

  def edit
    redirect_to root_path, notice: "No Access Right." unless @company == current_company
    @company.industry_relations.build if @company.industry_relations == []
  end

  def update
    if @company.update(company_params)
      redirect_to dashboard_company_path(@company.id)
    else
      render 'edit'
    end
  end

  def index
    @companies = Company.all.page(params[:page]).per(PER)
  end

  def dashboard
    redirect_to root_path, notice: "No Access Right." unless @company == current_company
  end

  private

  def set_company
    @company = Company.find_by(id: params[:id])
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
