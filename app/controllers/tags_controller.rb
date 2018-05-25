class TagsController < ApplicationController
  def index
    @tags = Tag.all
  end

  def show
    @tag = Tag.find(params[:id])
  end

  def update
  end

  def destroy
    @tag = Tag.find(params[:id])
    @prototype = Prototype.find(params[:prototype_id])
    if @tag.destroy
      redirect_to prototype_path(@prototype), notice: 'Tag was successfully deleted'
    end
  end

end
