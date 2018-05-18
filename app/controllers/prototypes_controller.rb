class PrototypesController < ApplicationController
  before_action :set_prototype, only: [:show, :edit, :update]

  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
    @prototype.captured_images.build
    @prototype.tags.build
  end

  def edit
    @captured_images_main = @prototype.captured_images.where("status='0'")
    @captured_images_sub = @prototype.captured_images.where("status='1'")
    @captured_images_new = @prototype.captured_images.build
    # 入力用のフォーム作成のため、buildメソッド使用
    @tags_new = @prototype.tags.build
    # 同上
    @tags_existing = @prototype.tags.where.not(id: nil)
    # tags_new を省くためにwhere.notを使用
  end

  def update
    tags = params[:prototype][:tags].reject(&:empty?)
    binding.pry
    if @prototype.user_id == current_user.id
      @prototype.update(prototype_update_params)
      @prototype.save_tags(tags)
      redirect_to :root, notice: 'Prototype was successfully updated'
      return
    else
      render action: :edit
      return
    end
  end

  def create
    @prototype = Prototype.new(prototype_create_params)
    if @prototype.save
      redirect_to :root, notice: 'New prototype was successfully created'
    else
      redirect_to ({ action: "new" }), alert: 'YNew prototype was unsuccessfully created'
     end
  end

  def show
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy if prototype.user_id == current_user.id
    redirect_to :root, notice: 'Prototype was successfully deleted'
  end

  private

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def prototype_create_params
    params.require(:prototype).permit(
      :title,
      :catch_copy,
      :concept,
      :user_id,
      captured_images_attributes: [:content, :status],
      tags_attributes: [:name]
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
