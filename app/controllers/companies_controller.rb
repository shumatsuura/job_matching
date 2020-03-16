class CompaniesController < ApplicationController

  before_action :set_company, only:[:show, :dashboard, :edit, :update]

  def show
  end

  def edit
  end

  def update
    if @company.update(company_params)
      redirect_to dashboard_company_path(@company.id)
    else
      render 'edit'
    end
  end

  def index
  end

  def dashboard

  end


  private

  def set_company
    @company = Company.find_by(id: params[:id])
  end

  def company_params
    params.require(:company).permit(:name)
  end

end
