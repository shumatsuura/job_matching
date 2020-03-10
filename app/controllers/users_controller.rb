class UsersController < ApplicationController
  def show
    @user = User.find_by(id: params[:id])
  end

  def index
  end

  def dashboard
    @user = User.find_by(id: params[:id])
  end


end
