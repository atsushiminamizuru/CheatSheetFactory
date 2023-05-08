class FavoritesController < ApplicationController
  before_action :set_sheet, only: [:create, :destroy]

  def create
    @favorite = Favorite.new(user_id: current_user.id, sheet_id: params[:sheet_id])
    @favorite.save
    @sheet.reload
    @favorite = Favorite.find_by(user_id: current_user.id, sheet_id: @sheet.id)
    render 'create.js.erb'
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    redirect_to root_path unless current_user.id == @favorite.user_id
    @favorite.destroy
    @sheet.reload
    @favorite = Favorite.find_by(user_id: current_user.id, sheet_id: @sheet.id)
    render 'destroy.js.erb'
  end

  def index
    @user = User.find(params[:user_id])

    @user_favorite_sheets = Sheet.includes(user: { profile_image_attachment: :blob })
                                 .joins(:favorites)
                                 .where(favorites: { user_id: @user.id })
                                 .order('favorites.created_at DESC')
                                 .page(params[:page])
  end

  private

  def set_sheet
    @sheet = Sheet.find(params[:sheet_id])
  end
end
