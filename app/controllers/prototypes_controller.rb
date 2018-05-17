class PrototypesController < ApplicationController
  before_action :set_prototype, only: [:show, :edit, :update]

  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
    @prototype.captured_images.build
  end

  def edit
    @captured_images_main = @prototype.captured_images.where("status='0'")
    @captured_images_sub = @prototype.captured_images.where("status='1'")
    @captured_images_new = @prototype.captured_images.build
  end

  def update
    if @prototype.user_id == current_user.id
      @prototype.update(prototype_update_params)
      redirect_to :root, notice: 'Prototype was successfully updated'
      return
    else
      render action: :edit
      return
    end
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to :root, notice: 'New prototype was successfully created'
    else
      redirect_to ({ action: "new" }), alert: 'YNew prototype was unsuccessfully created'
     end
  end

  def show
  end

  private

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def prototype_params
    params.require(:prototype).permit(
      :title,
      :catch_copy,
      :concept,
      :user_id,
      captured_images_attributes: [:content, :status]
    )
  end

  def prototype_update_params
    params.require(:prototype).permit(
      :title,
      :catch_copy,
      :concept,
      :user_id,
      captured_images_attributes: [:content, :status, :id]
    )
  end
end
