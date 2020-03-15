class CompaniesController < ApplicationController

  before_action :set_company, only:[:show, :dashboard, :edit, :update]

  def show
  end

  def edit
  end

  def update
  end

  def index
  end

  def dashboard

  end


  private
  def set_company
    
    @company = Company.find_by(id: params[:id])
  end
end
