class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :update, :create, :destroy, :like, :unlike]
  before_action :set_prototype, only: [:show, :edit, :update, :destroy, :like, :unlike]

  respond_to :html

  def index
    @prototypes = Prototype.all
    @users = User.all
    respond_with(@prototypes, @users)
  end

  def show
    # @attachments = PrototypeFileUploader.where(model: @prototype)
    @index = @prototype.attachments.find_by(file: 'index.html')
    @code = @prototype.attachments.find_by(file: 'app.coffee')
    @owner = User.find(@prototype.user_id)
    respond_with(@prototype, @index, @owner)
  end

  def new
    @prototype = Prototype.new
    # @attachments = @prototype.attachments.build
    respond_with(@prototype)
  end

  def edit
  end

  def create
    device = params['prototype']['device']
    description = params['prototype']['description']
    title = params['prototype']['title']
    files = params[:attachments]
    paths = params[:filename][0].split(/,/)
    
    @prototype = current_user.prototypes.build(title: title, device: device, description: description)
    
    files.each_with_index do |f, i|
      @prototype.attachments.push(Attachment.new(file: f, path: paths[i]))
    end

    @prototype.save!
    respond_with(@prototype)
  end

  def like
    @prototype.like current_user
    redirect_to @prototype
  end

  def unlike
    @prototype.unlike current_user
    redirect_to @prototype
  end

  def update
    @prototype.update(prototype_params)
    respond_with(@prototype)
  end

  def destroy
    @prototype.destroy
    respond_with(@prototype)
  end

  private
    def set_prototype
      @prototype = Prototype.find(params[:id])
    end

    def prototype_params
      params.require(:prototype).permit!
    end
end
