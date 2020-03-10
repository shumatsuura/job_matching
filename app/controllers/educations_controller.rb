class EducationsController < ApplicationController
  def new
    @user = current_user
    @education = @user.educations.build
    respond_to do |format|
      format.html { redirect_to edit_user_path(@user) }
    end
  end
  end
end
