class FriendshipsController < ApplicationController

  def create
    new_friendship = Friendship.create(user: current_user, friend: User.find(params[:friend]))
    user_name = User.find(new_friendship.friend_id).first_name  
    if new_friendship.save
      flash[:success] = "You are now tracking #{user_name}"
    else
      flash[:danger] = "There was something wrong with the friend request"
    end
    redirect_to my_friends_path
  end


  def destroy
    @tracking = current_user.friendships.find(params[:id])
    @tracking.destroy
    #if remote is true on the link Rails will look for a destroy.js.erb in a friendships view folder
  end

end
