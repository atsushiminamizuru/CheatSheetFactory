class CommentsController < ApplicationController
  before_action :comments_matching_login_user, only: [:edit, :update, :destroy]
  before_action :render_sheets_show, only: [:create, :edit, :update]
  before_action :comments_loading_of_login_user, only: [:create, :edit, :update]

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      flash[:notice] = 'It succeeded beautifully.'
      redirect_to sheet_path(id: params[:sheet_id])
    else
      render :"sheets/show"
    end
  end

  def edit
    render :"sheets/show"
  end

  def update
    if @comment.update(comment_params)
      flash[:notice] = 'It succeeded beautifully.'
      redirect_to sheet_path(id: params[:sheet_id])
    else
      render :"sheets/show"
    end
  end

  def destroy
    @comment.destroy
    flash[:notice] = 'It succeeded beautifully.'
    redirect_to sheet_path(id: params[:sheet_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, sheet_id: params[:sheet_id])
  end

  def comments_matching_login_user
    @comment = Comment.find(params[:id])
    redirect_to root_path unless current_user.id == @comment.user_id
  end

  def render_sheets_show
    @sheet = Sheet.with_attached_image.includes({ user: { profile_image_attachment: :blob }, image_attachment: :blob }).find(params[:sheet_id])
    @comments = @sheet.comments.includes(user: { profile_image_attachment: :blob }).order(created_at: :DESC).page(params[:page])
  end

  def comments_loading_of_login_user
    @load_login_user = User.with_attached_profile_image.find(current_user.id)
  end
end
