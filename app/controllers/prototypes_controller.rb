class PrototypesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_prototype, only: [:show, :edit, :update]

  def index
    @prototypes = Prototype.order("created_at DESC").page(params[:page]).per(8)
    respond_to do |format|
      format.html
      format.json
    end
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
    tags = params[:prototype][:tags].reject(&:empty?)
    @prototype = Prototype.new(prototype_create_params)
    if @prototype.save
      @prototype.save_tags(tags)
      redirect_to :root, notice: 'New prototype was successfully created'
    else
      redirect_to ({ action: "new" }), alert: 'New prototype was unsuccessfully created'
     end
  end

  def show
  end

  def destroy
    prototype = Prototype.find(params[:id])
    if prototype.user_id == current_user.id
      prototype.destroy
      redirect_to :root, notice: 'Prototype was successfully deleted'
    else
      render action: :edit
    end
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
