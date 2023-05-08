class RelationshipsController < ApplicationController
  before_action :set_user, only: [:create, :destroy]

  def create
    @relationship = Relationship.new(following_id: current_user.id, follower_id: params[:user_id])
    @relationship.save
    @user.reload
    @relationship = Relationship.find_by(following_id: current_user.id, follower_id: @user.id)
    render 'create.js.erb'
  end

  def destroy
    @relationship = Relationship.find(params[:id])
    redirect_to root_path unless current_user.id == @relationship.following_id
    @relationship.destroy
    @user.reload
    @relationship = Relationship.find_by(following_id: current_user.id, follower_id: @user.id)
    render 'destroy.js.erb'
  end

  def followings
    @user = User.find(params[:user_id])
    @user_followings = @user.followings.with_attached_profile_image.order('relationships.created_at DESC').page(params[:page])
  end

  def followers
    @user = User.find(params[:user_id])
    @user_followers = @user.followers.with_attached_profile_image.order('relationships.created_at DESC').page(params[:page])
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
