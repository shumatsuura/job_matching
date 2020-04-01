class Notification < ApplicationRecord

  def url
    case action_model
    when "scout"
      "/scouts/#{action_model_id}/scout_messages"
    when "apply"
      "/posts/#{Apply.find_by(id: action_model_id).post_id}/manage"
    when "scout_message"
      "/scouts/#{ScoutMessage.find_by(id: action_model_id).scout_id}/scout_messages"
    when "apply_message"
      "/applies/#{ApplyMessage.find_by(id: action_model_id).apply_id}/apply_messages"
    when "follow"
      "/users/#{Follow.find_by(id: action_model_id).user_id}"
    when "like_post"
      "/users/#{LikePost.find_by(id: action_model_id).user_id}"
    end

  end

  def message
    case action_model
    when "scout"
      "You are scouted by #{Scout.find_by(id: action_model_id).company.name}"
    when "apply"
      "You have new applicaiton for post from #{Apply.find_by(id: action_model_id).user.first_name} ."
    when "scout_message"
      if target_model == "user"
        "You have new message from #{ScoutMessage.find_by(id: action_model_id).scout.company.name}."
      elsif target_model == "company"
        "You have new message from #{ScoutMessage.find_by(id: action_model_id).scout.user.first_name}."
      end
    when "apply_message"
      if target_model == "user"
        "You have new message from #{ApplyMessage.find_by(id: action_model_id).post.company.name}."
      elsif target_model == "company"
        "You have new message from #{ApplyMessage.find_by(id: action_model_id).apply.user.first_name}."
      end
    when "follow"
      "You are followed by #{Follow.find_by(id: action_model_id).user.first_name}"
    when "like_post"
      "Your post is liked by #{LikePost.find_by(id: action_model_id).user.first_name}"
    end
  end
end
