class UsersController < ApplicationController
  before_action :set_user, only: [:show, :follow, :unfollow, :followers]
  respond_to :html
  def show
    respond_with(@user)
  end

  def follow
    current_user.follow(@user)
    redirect_to :back
  end
  
  def unfollow
    current_user.unfollow(@user)
    redirect_to :back
  end

  def followers
    @followers = @user.all_followers
    respond_with(@user, @followers)
  end

  private
    def set_user
      @user = User.find(params[:id])
    end
end


# I WANT TO SEE:
# - When someone likes one of my prototypes
#   - PublicActivity::Activity.where(:trackable_id.in => my_prototypes_ids)
# - When someone adds a comment on one of my prototypes
# - When I hit 100 views, 1000 views, 5000 views, 10,000 views, etc
# - When I hit 50 likes, 100 likes, 500 likes, etc

# ON MY HOMESCREEN:
# - Prototypes that my followees have submitted