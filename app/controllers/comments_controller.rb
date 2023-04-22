class CommentsController < ApplicationController
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
    @sheet = Sheet.find(params[:sheet_id])
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      flash[:notice] = 'It succeeded beautifully.'
      redirect_to sheet_path(@sheet.id)
    else
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
end
