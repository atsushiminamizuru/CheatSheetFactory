class FavoritesController < ApplicationController
  def create
    @favorite = Favorite.new(user_id: current_user.id, sheet_id: params[:sheet_id])
    @favorite.save
    flash[:notice] = 'It succeeded beautifully.'
    redirect_to sheet_path(id: params[:sheet_id])
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    redirect_to root_path unless current_user.id == @favorite.user_id
    @favorite.destroy
    flash[:notice] = 'It succeeded beautifully.'
    redirect_to sheet_path(id: params[:sheet_id])
  end

  def index
    @user = User.find(params[:user_id])

    @user_favorite_sheets = Sheet.includes(user: { profile_image_attachment: :blob })
                                 .joins(:favorites)
                                 .where(favorites: { user_id: @user.id })
                                 .order('favorites.created_at DESC')
                                 .page(params[:page])
  end
end
