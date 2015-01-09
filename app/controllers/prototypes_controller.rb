class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :update, :create, :destroy, :like, :unlike]
  before_action :set_prototype, only: [:show, :edit, :update, :destroy, :like, :unlike]

  respond_to :html

  def index
    listing = params[:listing]
    if listing == 'top'
      @prototypes = Prototype.order("likes desc").limit(25)
    elsif listing == 'rising'
      @prototypes = Prototype.where(:created_at.gte => 1.week.ago).order("likes desc").limit(25)
    elsif listing == 'newest'
      @prototypes = Prototype.order("created_at desc").limit(25)
    else
      if user_signed_in?
        if current_user.all_followees.count > 0
          follower_ids = current_user.followees.only(:f_id).map(&:f_id)
          @prototypes = Prototype.where(:user_id.in => follower_ids).order("created_at desc").limit(25)
        else
          @prototypes = Prototype.order("likes desc").limit(25)
        end
      else
        @prototypes = Prototype.order("likes desc").limit(25)
      end
    end
    @users = User.all
    respond_with(@prototypes, @users)
  end

  def show
    # @attachments = PrototypeFileUploader.where(model: @prototype)
    @index = @prototype.attachments.find_by(file: 'index.html')
    @code = @prototype.attachments.find_by(file: 'app.coffee')
    @comments = @prototype.comments
    # @new_comment = @prototype.comments.build()
    @owner = User.find(@prototype.user_id)
    render :layout => 'navless'
  end

  def new
    @prototype = Prototype.new
    @devices = ['iPhone 6', 'iPhone 5s/5c', 'iPad', 'Nexus 5', 'Apple Watch', 'Desktop']
    # @attachments = @prototype.attachments.build
    respond_with(@prototype, @devices)
  end

  def edit
  end

  def create
    device = params['prototype']['device']
    description = params['prototype']['description']
    title = params['prototype']['title']
    preview = params['prototype']['preview']
    tags = params['prototype']['tags']
    files = params[:attachments]
    paths = params[:filename][0].split(/,/)
    @prototype = current_user.prototypes.build(title: title, device: device, description: description, tags: tags)
    @prototype.preview = Preview.new(image: preview, user_id: current_user.id)
    files.each_with_index do |f, i|
      @prototype.attachments.push(Attachment.new(file: f, original_filename: f.original_filename, path: paths[i], user_id: current_user.id))
    end
    @prototype.save!
    respond_with(@prototype)
  end

  def like
    @prototype.like current_user
    @prototype.create_activity key: 'prototype.liked_by', owner_id: current_user.id, owner: current_user
    redirect_to :back
  end

  def unlike
    @prototype.unlike current_user
    activity = PublicActivity::Activity.where(key: 'prototype.liked_by', trackable_id: @prototype.id, owner_id: current_user.id)
    activity.destroy
    redirect_to :back
  end

  def update
    device = params['prototype']['device']
    description = params['prototype']['description']
    title = params['prototype']['title']
    preview = params['prototype']['preview']
    tags = params['prototype']['tags']
    files = params[:attachments]
    paths = params[:filename][0].split(/,/)
    if preview
      @prototype.preview.destroy
      @prototype.preview = Preview.new(image: preview)
    end
    if files
      @prototype.attachments.destroy_all
      files.each_with_index do |f, i|
        @prototype.attachments.push(Attachment.new(file: f, original_filename: f.original_filename, path: paths[i]))
      end
    end
    @prototype.update!(title: title, device: device, description: description, tags: tags)
    respond_with(@prototype)
  end

  def destroy
    @prototype.destroy
    @activity = PublicActivity::Activity.where(trackable_id: @prototype.id)
    @activity.destroy
    redirect_to '/'
  end

  private
    def set_prototype
      @prototype = Prototype.find(params[:id])
    end

    def prototype_params
      params.require(:prototype).permit!
    end
end
