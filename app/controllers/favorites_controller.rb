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

    user_favorites_sheets = @user.favorites
                                 .includes(sheet: { user: :profile_image_attachment, image_attachment: :blob })
                                 .order('favorites.created_at DESC')
                                 .map(&:sheet)

    @user_favorite_sheets = Kaminari.paginate_array(user_favorites_sheets).page(params[:page])

    @load_login_user = User.with_attached_profile_image
                           .includes({ sheets: :image_attachment }, :followings, :followers)
                           .find(current_user.id)
  end
end
