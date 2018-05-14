class CommentsController < ApplicationController
  def create
    Comment.create(comment_params)
    redirect_to prototype_path(id:params[:prototype_id])
  end

  def edit

  end

  def update
  end

  def destroy
  end

  private
    def comment_params
      params.require(:comment).permit(:body,:prototype_id).merge(user_id: current_user.id)
    end

end
