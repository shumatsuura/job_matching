class PostsController < ApplicationController
  before_action :set_post, only:[:edit, :update, :show, :manage, :destroy]
  before_action :authenticate_company!, only:[:destroy]
  before_action :authenticate_company_without_admin_user, only:[:new, :create, :edit, :update, :manage]
  before_action :ensure_correct_user, only: [:edit, :update, :manage]

  PER = 10

  def index
    @industries = Industry.all
    @job_categories = JobCategory.all
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).order(updated_at: "DESC").page(params[:page]).per(PER)
  end

  def new
    @company = current_company || Company.find_by(id: params[:company_id])
    if @company.name.present?
      @post = @company.posts.build
      @post.post_industries.build
      @post.post_job_categories.build
      @post.post_skills.build
      @skills = @company.company_skills
    else
      redirect_to dashboard_company_path(@company.id), alert: "Please enter profile Information before posting."
    end
  end

  def create
    @company = current_company || Company.find_by(id: params[:post][:company_id])
    @post = @company.posts.build(post_params)
    if @post.save
      redirect_to post_path(@post), notice: 'Created post successfully.'
    else
      render 'new'
    end
  end

  def edit
    @company = @post.company
    @skills = @company.company_skills
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post), notice: 'Updated post successfully.'
    else
      render 'edit'
    end
  end

  def show
  end

  def manage
  end

  def destroy
    @post.destroy
    redirect_to dashboard_company_path(@post.company.id), notice: "Deleted a post successfully."
  end

  private

  def post_params
    params.require(:post).permit(
      :title,
      :salary,
      :number_of_recruits,
      :position,
      :description,
      :location,
      :company_id,
      :status,
      skill_ids: [],
      post_industries_attributes: [:id, :post_id, :industry_id],
      post_job_categories_attributes: [:id, :post_id, :job_category_id],
      post_skills_attributes: [:id, :post_id, :company_skill_id],
    )
  end

  def ensure_correct_user
    redirect_to root_path, notice: "No Access Right." unless @post.company == current_company || admin_user?
  end

  def set_post
    @post = Post.find_by(id: params[:id])
  end

end
