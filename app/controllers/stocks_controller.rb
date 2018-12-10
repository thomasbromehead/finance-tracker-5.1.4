class StocksController < ApplicationController

  def search
    if params[:stock].present?
      @stock = Stock.new_from_lookup(params[:stock])
      if @stock
        respond_to do |format|
          format.js { render partial: "users/result"}
          format.html { render 'users/my_portfolio'}
        end
      else
        flash[:danger] = "You've entered an incorrect symbol"
        render 'users/my_portfolio'
      end
    else
      flash[:danger] = "You've entered an empty search string"
      redirect_to my_portfolio_path
    end
  end

end
