class UserStocksController < ApplicationController

  def create
    stock = Stock.find_by_ticker(params[:stock_sticker])
    if stock.blank?
      stock = Stock.new_from_lookup(params[:stock_ticker])
      stock.save
    end
    @user_stock = UserStock.create(user: current_user, stock: stock)
    flash[:success] = "Stock #{stock.name} was successfully added to portfolio"
    redirect_to my_portfolio_path
  end 


  def destroy
    #We are not deleting the stock but the association!
    @user_stock = UserStock.find(params[:id])
    @user_stock.destroy
    flash[:danger] = "Stock was successfully removed from portfolio"
    redirect_to my_portfolio_path
  end

end
