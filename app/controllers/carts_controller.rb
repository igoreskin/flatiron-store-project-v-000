class CartsController < ApplicationController

  def show
    @current_cart = Cart.find(params[:id])
  end

  def checkout
    @cart = Cart.find(params[:id])
    @cart.update(status: 'submitted')
    @cart.line_items.each do |line_item|
      line_item.item.inventory -= line_item.quantity
      line_item.item.save
    end
    current_user.current_cart_id = nil
    current_user.save
    flash[:notice] = "The cart has been submitted"
    redirect_to cart_path(@cart)
  end

end
