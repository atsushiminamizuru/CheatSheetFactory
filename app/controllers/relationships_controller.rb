class RelationshipsController < ApplicationController
  def create
    @relationship = Relationship.new(following_id: current_user.id, follower_id: params[:user_id])
    @relationship.save
    flash[:notice] = 'It succeeded beautifully.'
    redirect_to user_path(id: params[:user_id])
  end

  def destroy
    @relationship = Relationship.find(params[:id])
    redirect_to root_path unless current_user.id == @relationship.following_id
    @relationship.destroy
    flash[:notice] = 'It succeeded beautifully.'
    redirect_to user_path(id: params[:user_id])
  end

  def followings
    @user = User.find(params[:user_id])
    @user_followings = @user.followings.with_attached_profile_image.includes(
      active_relationships: :follower
    ).order('relationships.created_at DESC').page(params[:page])

    @load_login_user = User.with_attached_profile_image.includes(:sheets, :followings, :followers).find(current_user.id)
  end

  def followers
    @user = User.find(params[:user_id])
    @user_followers = @user.followers.with_attached_profile_image.includes(
      passive_relationships: :following
    ).order('relationships.created_at DESC').page(params[:page])
    @load_login_user = User.with_attached_profile_image.includes(:sheets, :followings, :followers).find(current_user.id)
  end
end
