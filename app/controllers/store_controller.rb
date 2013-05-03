class StoreController < ApplicationController
  skip_before_filter :authorize
  def index
    #@products = Product.all

    @cart = current_cart


      if session[:counter].nil?
        session[:counter] = 0
      end
      session[:counter] += 1



      if params[:set_locale]
        redirect_to store_path(:locale => params[:set_locale])
      else
        @products = Product.all
        @cart = current_cart
      end


  end
end
