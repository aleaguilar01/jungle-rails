class Admin::DashboardController < ApplicationController
  def show
    @categories = Category.all
    @categories_count = Category.count
    @product_count = Product.count
  end
end
