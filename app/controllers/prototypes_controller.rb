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
    @captured_images = @prototype.captured_images
  end

  def update
    @prototype.update(prototype_params) if @prototype.user_id == current_user.id
    redirect_to :root, notice: 'Prototype was successfully updated'
    return
    else
      render action: :edit
      return
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
end
