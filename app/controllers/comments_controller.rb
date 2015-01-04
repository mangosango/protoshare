class CommentsController < ApplicationController
  # before_action :authenticate_user!, only: [:new, :edit, :update, :create, :destroy]
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def show
    respond_with(@comment)
  end

  def new
    @comment = Comment.new
    respond_with(@comment)
  end

  def edit
  end

  def create
    prototype = Prototype.find(params[:prototype_id])
    @comment = prototype.comments.create(body: params['comment']['body'], author: current_user.id, authorname: current_user.username)
    prototype.create_activity key: 'prototype.comment_added', owner_id: current_user.id, owner: current_user
    redirect_to(:back)
  end

  def update
    @comment.update(comment_params)
    redirect_to(:back)
  end

  def destroy
    @comment.destroy
    activity = PublicActivity::Activity.where(key: 'prototype.comment_added', trackable_id: @comment.prototype_id, owner_id: current_user.id)
    activity.destroy
    redirect_to(:back)
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit!
    end
end
