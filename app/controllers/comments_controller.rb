class CommentsController < ApplicationController
  before_action :comments_matching_login_user, only: [:edit, :update, :destroy]
  
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      flash[:notice] = 'It succeeded beautifully.'
      redirect_to sheet_path(@comment.sheet_id)
    else
      @sheet = Sheet.find(params[:sheet_id])
      @comments = @sheet.comments.includes(:user).order('created_at DESC')
      render :"sheets/show"
    end
  end

  def edit
    @sheet = Sheet.find(params[:sheet_id])
    @comment = Comment.find(params[:id])
    @comments = @sheet.comments.includes(:user).order('created_at DESC')
    render :"sheets/show"
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      flash[:notice] = 'It succeeded beautifully.'
      redirect_to sheet_path(@comment.sheet_id)
    else
      @sheet = Sheet.find(params[:sheet_id])
      @comments = @sheet.comments.includes(:user).order('created_at DESC')
      render :"sheets/show"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:notice] = 'It succeeded beautifully.'
    redirect_to sheet_path(@comment.sheet_id)
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, sheet_id: params[:sheet_id])
  end
  
  def comments_matching_login_user
    @comment = Comment.find(params[:id])
    redirect_to root_path unless current_user.id == @commnent.user_id
  end
end
