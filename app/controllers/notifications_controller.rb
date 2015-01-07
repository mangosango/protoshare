class NotificationsController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  respond_to :html
  
  def index
    # follower_ids = current_user.followees.only(:f_id).map(&:f_id)
    prototype_ids = current_user.prototypes.only(:_id).map(&:_id)
    @activities = PublicActivity::Activity.order("created_at desc").where(:trackable_id.in => prototype_ids).limit(5)
    render :layout => 'navless'
  end
end