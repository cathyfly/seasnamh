class CommentsController < ApplicationController

  before_action :authenticate_user!

  def create
    @comment.user = current_user
  end

  def destroy
  end

  private
  def comment_params
    params.require(:comment).permit(s:comment_text)
  end


end
