class TagsController < ApplicationController
  def index
    @tags = Tag.all
  end

  def show
    @tag = Tag.find(params[:id])
  end

  def destroy
    @tag = Tag.find(params[:id])
    @prototype = Prototype.find(params[:prototype_id])
    @prototype_tag = PrototypeTag.find_by(tag_id: params[:id], prototype_id: params[:prototype_id])
    if user_signed_in? && current_user.id == @prototype.user.id
      @prototype_tag.destroy
      redirect_to prototype_path(@prototype), notice: 'Tag was successfully deleted'
    else
       redirect_to prototype_path(@prototype), alert: 'Tag was unsuccessfully deleted'
    end
  end

end
