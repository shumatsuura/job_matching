class Admin::PostsController < ApplicationController
  before_action :set_post, only:[ :destroy]
  before_action :ensure_admin_user

  PER = 10

  def index
    @industries = Industry.all
    @job_categories = JobCategory.all
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).order(updated_at: "DESC").page(params[:page]).per(PER)
  end

  def destroy
    @post.destroy
    redirect_to admin_posts_path, notice: "Deleted a post successfully."
  end

  private

  def set_post
    @post = Post.find_by(id: params[:id])
  end

end
