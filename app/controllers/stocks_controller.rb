class StocksController < ApplicationController

  def search
    if params[:stock].blank?
      flash.now[:danger] = "You've entered an empty search string"
    else
      @stock = Stock.new_from_lookup(params[:stock])
      flash.now[:danger] = "You've entered an incorrect symbol" unless @stock
    end

    respond_to do |format|
      format.js { render partial: "stocks/result" }
      format.html { render 'users/my_portfolio' }
    end    

  end

end
