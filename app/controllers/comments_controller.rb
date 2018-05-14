class CommentsController < ApplicationController
  def create
    Comment.create(body:params[:body],prototype_id:params[:prototype_id],user_id:[current_user.id])
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

    end

end
