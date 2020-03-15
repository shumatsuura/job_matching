class PostsController < ApplicationController
  before_action :set_post, only:[:edit,:update,:show]

  def new

    @post = current_company.posts.build
  end

  def create
    @post = current_company.posts.build(post_params)
    if @post.save
      redirect_to post_path(@post)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
  end

  def show
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
    )
  end

  def set_post
    @post = Post.find_by(id: params[:id])
  end

end
