class Notification < ApplicationRecord

  def url
    case action_model
    when "scout"
      Scout.find_by(id: action_model_id).present? ? "/scouts/#{action_model_id}/scout_messages" : "/"
    when "apply"
      Apply.find_by(id: action_model_id).present? ? "/posts/#{Apply.find_by(id: action_model_id).post_id}/manage" : "/"
    when "scout_message"
      ScoutMessage.find_by(id: action_model_id).present? ? "/scouts/#{ScoutMessage.find_by(id: action_model_id).scout_id}/scout_messages" : "/"
    when "apply_message"
      ApplyMessage.find_by(id: action_model_id).present? ? "/applies/#{ApplyMessage.find_by(id: action_model_id).apply_id}/apply_messages" : "/"
    when "follow"
      Follow.find_by(id: action_model_id).present? ? "/users/#{Follow.find_by(id: action_model_id).user_id}" : "/"
    when "like_post"
      LikePost.find_by(id: action_model_id).present? ? "/users/#{LikePost.find_by(id: action_model_id).user_id}" : "/"
    end
  end

  def message
    case action_model
    when "scout"
      Scout.find_by(id: action_model_id).present? ? "You are scouted by #{Scout.find_by(id: action_model_id).company.name}" : "Deleted"
    when "apply"
      Apply.find_by(id: action_model_id).present? ? "You have new applicaiton for post from #{Apply.find_by(id: action_model_id).user.first_name} ." : "Deleted"
    when "scout_message"
      if target_model == "user"
        ScoutMessage.find_by(id: action_model_id).present? ? "You have new message from #{ScoutMessage.find_by(id: action_model_id).scout.company.name}." : "Deleted"
      elsif target_model == "company"
        ScoutMessage.find_by(id: action_model_id).present? ? "You have new message from #{ScoutMessage.find_by(id: action_model_id).scout.user.first_name}." : "Deleted"
      end
    when "apply_message"
      if target_model == "user"
        ApplyMessage.find_by(id: action_model_id).present? ? "You have new message from #{ApplyMessage.find_by(id: action_model_id).post.company.name}." : "Deleted"
      elsif target_model == "company"
        ApplyMessage.find_by(id: action_model_id).present? ? "You have new message from #{ApplyMessage.find_by(id: action_model_id).apply.user.first_name}." : "Deleted"
      end
    when "follow"
      Follow.find_by(id: action_model_id).present? ? "You are followed by #{Follow.find_by(id: action_model_id).user.first_name}" : "Deleted"
    when "like_post"
      LikePost.find_by(id: action_model_id).present? ? "Your post is liked by #{LikePost.find_by(id: action_model_id).user.first_name}" : "Deleted"
    end
  end

  def time
    created_at.strftime("%m/%d/%y at %l:%M %p")
  end
end
