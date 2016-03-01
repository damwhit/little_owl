class CartController < ApplicationController
  include ActionView::Helpers::TextHelper

  def create
    product = Product.find(params[:product_id])
    @cart.add_product(product.id)
    session[:cart] = @cart.contents
    flash[:info] = "#{product.name} added to cart"
    redirect_to products_path
  end

  def index
    ids = session[:cart]
    @products = ids.map do |id, quantity|
      [Product.find(id.to_i), quantity]
    end
  end
end