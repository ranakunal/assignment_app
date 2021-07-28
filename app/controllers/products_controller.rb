class ProductsController < ApplicationController
  def index
    @product = Product.new
    ActionCable.server.broadcast('notification_channel', 'You have visited the welcome page.')
  end

  def create
   
  end

end
