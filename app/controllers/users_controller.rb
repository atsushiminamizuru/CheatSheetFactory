class UsersController < ApplicationController
  before_action :users_matching_login_user, only: [:edit, :update]
  before_action :ensure_guest_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @sheets = @user.sheets.includes(:user).order(created_at: :DESC)
    @relationship = Relationship.find_by(following_id: current_user.id, follower_id: @user.id)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = 'It succeeded beautifully.'
      redirect_to user_path(id: params[:id])
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:introduction, :name, :profile_image)
  end

  def users_matching_login_user
    @user = User.find(params[:id])
    redirect_to root_path unless current_user.id == @user.id
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "guestuser"
      redirect_to user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end  
end
