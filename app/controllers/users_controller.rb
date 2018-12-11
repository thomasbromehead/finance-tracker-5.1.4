class UsersController < ApplicationController
  
  def my_portfolio
    @user = current_user
    @user_stocks = current_user.stocks
  end

  def my_friends
    @friendships = current_user.friends
  end


  def search
    if params[:friend_name].blank?
      flash.now[:danger] = "You didn't search for anyone"
    else
      @users = User.search(params[:friend_name])
      @users = current_user.except_current_user(@users)
    end

    respond_to do |format|
      format.js { render partial: 'friends/friend-result' }
      format.html { render 'users/my_friends'}
    end
  end  
  
  
end
