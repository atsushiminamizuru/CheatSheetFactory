class SheetsController < ApplicationController
  before_action :sheets_matching_login_user, only: [:edit, :update, :destroy]
  before_action :sheets_loading_of_login_user, only: [:index, :show, :search]

  def new
    @sheet = Sheet.new
  end

  def create
    @sheet = Sheet.new(sheet_params)
    if @sheet.save
      flash[:notice] = 'It succeeded beautifully.'
      redirect_to sheets_path
    else
      render :new
    end
  end

  def index
    @sheets = Sheet.with_attached_image
                   .includes({ user: { profile_image_attachment: :blob }, image_attachment: :blob })
                   .order(created_at: :DESC)
                   .page(params[:page])
  end

  def show
    @sheet = Sheet.with_attached_image.includes({ user: :profile_image_attachment }, :favorites).find(params[:id])
    @comment = Comment.new
    @comments = @sheet.comments.includes(user: :profile_image_attachment).order(created_at: :DESC).page(params[:page])
    @favorite = Favorite.find_by(user_id: current_user.id, sheet_id: @sheet.id)
  end

  def edit
  end

  def update
    if @sheet.update(sheet_params)
      flash[:notice] = 'It succeeded beautifully.'
      redirect_to sheet_path(id: params[:id])
    else
      render :edit
    end
  end

  def destroy
    @sheet.destroy
    flash[:notice] = 'It succeeded beautifully.'
    redirect_to sheets_path
  end

  def search
    @sheets = Sheet.search(params[:keyword], params[:page])
    render :index
  end

  private

  def sheet_params
    params.require(:sheet).permit(:title, :content, :genre_id, :image).merge(user_id: current_user.id)
  end

  def sheets_matching_login_user
    @sheet = Sheet.find(params[:id])
    redirect_to root_path unless current_user.id == @sheet.user_id
  end

  def sheets_loading_of_login_user
    @load_login_user = User.with_attached_profile_image.find(current_user.id)
  end
end
