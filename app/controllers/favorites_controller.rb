class FavoritesController < ApplicationController
  def create
    @favorite = Favorite.new(user_id: current_user.id, sheet_id: params[:sheet_id])
    @favorite.save
    flash[:notice] = 'It succeeded beautifully.'
    redirect_to sheet_path(@favorite.sheet_id)
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    redirect_to root_path unless current_user.id == @favorite.user_id
    @favorite.destroy
    flash[:notice] = 'It succeeded beautifully.'
    redirect_to sheet_path(@favorite.sheet_id)
  end

  def index
    @user = User.find(params[:user_id])
    user_favorites_sheets = @user.favorites.includes(sheet: :user).order('favorites.created_at DESC')
    @user_favorite_sheets = user_favorites_sheets.map(&:sheet)
  end
end
