class PrototypesController < ApplicationController
  before_action :set_prototype, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @prototypes = Prototype.all
    respond_with(@prototypes)
  end

  def show
    respond_with(@prototype)
  end

  def new
    @prototype = Prototype.new
    respond_with(@prototype)
  end

  def edit
  end

  def create
    @prototype = Prototype.new(prototype_params)
    @prototype.save
    respond_with(@prototype)
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
      params.require(:prototype).permit(:folder, :device, :description)
    end
end
