class OrdersController < ApplicationController
  before_action :authenticate_user

  def create
    carted_products = CartedProduct.where(user_id: current_user.id, status: "carted")
    calculated_subtotal = 0
    carted_products.each do |carted_product|
      calculated_subtotal += carted_product.product.price * carted_product.quantity
    end

    calculated_tax = calculated_subtotal * 0.09
    calculated_total = calculated_subtotal + calculated_tax

    @order = Order.create(
      user_id: current_user.id,
      subtotal: calculated_subtotal,
      tax: calculated_tax,
      total: calculated_total,
    )
    carted_products.each do |carted_product|
      carted_product.update(status: "purchased", order_id: @order.id)
    end
    render :show
  end

  def show
    @order = Order.find_by(id: params[:id])
    if @order.user_id == current_user.id
      render :show
    else
      render json: { message: "Not for You!" }
    end
  end

  def index
    @orders = current_user.orders
    render :index
  end

  # The current user show and index would need to be able to verify based on JWT, so we would need some authorization code, and I believe some before actions here.  The index one may already work since we are setting the "current_user.id"  "Show" should be different?

end
