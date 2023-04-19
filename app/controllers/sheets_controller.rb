class SheetsController < ApplicationController
  before_action :matching_login_user?, only: [:edit, :update, :destroy]
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
    @sheets = Sheet.includes(:user).order('created_at DESC')
  end

  def show
    @sheet = Sheet.find(params[:id])
  end

  def edit
    @sheet = Sheet.find(params[:id])
  end

  def update
    @sheet = Sheet.find(params[:id])
    if @sheet.update(sheet_params)
      flash[:notice] = 'It succeeded beautifully.'
      redirect_to sheet_path(@sheet.id)
    else
      render :edit
    end
  end

  def destroy
    @sheet = Sheet.find(params[:id])
    @sheet.destroy
    redirect_to sheets_path
  end

  private

  def sheet_params
    params.require(:sheet).permit(:title, :content, :genre_id, :image).merge(user_id: current_user.id)
  end

  def matching_login_user?
    @sheet = Sheet.find(params[:id])
    redirect_to sheets_path unless current_user.id == @sheet.user_id
  end
end
