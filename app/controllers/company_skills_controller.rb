class CompanySkillsController < ApplicationController

  before_action :set_company_skill, only:[:edit,:update,:destroy]

  def index
    @company_skills = CompanySkill.where(company_id: current_company.id)
  end

  def new
    @company_skill = CompanySkill.new
  end

  def create
    if @company_skill = current_company.company_skills.create(company_skill_params)
      redirect_to company_skills_path, notice: "Created new skill successfully."
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    @company_skill.update(company_skill_params)
    redirect_to company_skills_path, notice: "Updated skill successfully."
  end

  def destroy
    @company_skill.destroy
    redirect_to company_skills_path, notice: "Deleted skill successfully."
  end

  private

  def set_company_skill
    @company_skill = CompanySkill.find_by(id: params[:id])
  end

  def company_skill_params
    params.require(:company_skill).permit(:name,:company_id)
  end
end
