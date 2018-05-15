class CommentsController < ApplicationController
  def create
    @comment=Comment.create(comment_params)
    respond_to do |format|
      format.html {redirect_to prototype_path(id:params[:prototype_id])}
      format.json
    end
  end

  def edit

  end

  def update
  end

  def destroy
  end

  private
    def comment_params
      params.require(:comment).permit(:body).merge(prototype_id:params[:prototype_id],user_id: current_user.id)
    end

end
