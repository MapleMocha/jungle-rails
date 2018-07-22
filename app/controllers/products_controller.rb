class ProductsController < ApplicationController

  def index
    @products = Product.all.order(created_at: :desc)
  end

  def show
    @product = Product.find params[:id]
    @reviews = Review.where(product_id: @product.id)
    @reviews = @reviews.order(id: :desc).all
    @review = Review.new

  end

end
