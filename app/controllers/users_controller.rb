class UsersController < ApplicationController
  before_action :matching_login_user, only: [:edit, :update]
  def show
    @user = User.find(params[:id])
    @sheets = @user.sheets.order(created_at: :desc)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = 'It succeeded beautifully.'
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:introduction, :name, :profile_image)
  end

  def matching_login_user
    @user = User.find(params[:id])
    redirect_to user_path(@user.id) unless current_user.id == @user.id
  end
end
