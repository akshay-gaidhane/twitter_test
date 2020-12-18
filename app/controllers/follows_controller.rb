class FollowsController < ApplicationController
	before_action :authenticate_user!
  def dofollow
  	user_id = params[:user_id]
  	follow = Follow.new(follower_id: current_user.id, followed_user_id: user_id)
  	respond_to do |format|
      if follow.save
        format.html { redirect_to tweets_path, notice: 'You Followed successfully.' }
      else
      	format.html { redirect_to tweets_path, notice: 'Error.' }
      end
    end
  end

  def unfollow
  	user_id = params[:user_id]
  	follow = Follow.where(follower_id: current_user.id, followed_user_id: user_id).last
  		
  	follow.destroy
    respond_to do |format|
      format.html { redirect_to tweets_path, notice: 'You Unfollowed successfully.' }
    end
  end
end
