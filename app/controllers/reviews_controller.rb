class ReviewsController < ApplicationController
  before_action :require_login

  def create
    @review = Review.new(review_params)
    @review.user = current_user
    puts "HERE: ", @review.inspect
    @product = Product.find(@review.product_id)

    if @review.save
      redirect_to [@product]
      puts "review added..."
    else
      redirect_to [@product]
      puts "review NOT added..."
    end
  end

  def destroy
    @review = Review.find params[:id]
    @product = Product.find(@review.product_id)
    @review.destroy
    redirect_to [@product], notice: 'Review deleted!'
  end

  private

  def review_params
    params.require(:review).permit(
      :description,
      :rating,
      :product_id,
    )
  end

  def require_login
    unless current_user
      flash[:notice] = 'Login First Please'
      redirect_to :products
    end
  end

end
