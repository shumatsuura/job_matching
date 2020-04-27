class LikePostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @like_posts = current_user.like_posts.order(created_at: "DESC")
  end

  def create
    like_post = current_user.like_posts.create(like_post_params)
    notification = Notification.create(
      target_model: "company",
      target_model_id: like_post.post.company_id,
      action_model: "like_post",
      action_model_id: like_post.id)
    notification.message = notification.create_message
    notification.save
    redirect_to post_path(like_post.post_id)
  end

  def destroy
    like_post = current_user.like_posts.find_by(post_id: params[:post_id]).destroy
    redirect_to post_path(like_post.post_id)
  end

  private

  def like_post_params
    params.require(:like_post).permit(:user_id, :post_id)
  end
end
