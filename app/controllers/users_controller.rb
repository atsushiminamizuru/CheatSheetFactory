class UsersController < ApplicationController
  before_action :users_matching_login_user, only: [:edit, :update]
  before_action :ensure_guest_user, only: [:edit, :update]
  before_action :users_loading_of_login_user, only: [:show]

  def show
    @user = User.with_attached_profile_image
                .includes({ sheets: :image_attachment }, :followings, :followers, :favorites)
                .find(params[:id])

    @sheets = @user.sheets
                   .with_attached_image
                   .includes({ user: :profile_image_attachment }, :favorites)
                   .order(created_at: :DESC)
                   .page(params[:page])

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
    return unless @user.name == 'guestuser'

    redirect_to user_path(current_user), notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
  end

  def users_loading_of_login_user
    @load_login_user = User.with_attached_profile_image
                           .includes({ sheets: :image_attachment }, :followings, :followers)
                           .find(current_user.id)
  end
end
