class LineItemsController < ApplicationController
  skip_before_filter :authorize, :only => :create
  # GET /line_items
  # GET /line_items.json
  def index
    @line_items = LineItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @line_items }
    end
  end

  # GET /line_items/1
  # GET /line_items/1.json
  def show
    begin
      @line_item = LineItem.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      @msg = "Attempt to access invalid lineItem #{params[:id]}"
      logger.error @msg
      Norifier.send_error_to_admin(@msg).deliver
      redirect_to store_url, :notice => 'Invalid lineItem'
     else
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @line_item }
      end
    end
  end

  # GET /line_items/new
  # GET /line_items/new.json
  def new
    @line_item = LineItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @line_item }
    end
  end




  # GET /line_items/1/edit
  def edit
    @line_item = LineItem.find(params[:id])
  end

  # POST /line_items
  # POST /line_items.json
  def create
    logger.info 'line_items_controller.create'
    @cart = current_cart
    product = Product.find(params[:product_id])  #The params object is important inside Rails applications.
    #It holds all of the parameters passed in a browser request
    @line_item = @cart.add_product(product.id)

    session[:counter] = 0

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to(store_url) }
        format.js   { @current_item = @line_item }   #see view/line_items/create.js.rjs
        format.json { render json: @line_item, status: :created, location: @line_item }
      else
        format.html { render action: "new" }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /line_items/1
  # PUT /line_items/1.json
  def update
    @line_item = LineItem.find(params[:id])

    respond_to do |format|
      if @line_item.update_attributes(params[:line_item])
        format.html { redirect_to @line_item, notice: 'Line item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy

    @cart = current_cart
    @line_item = @cart.remove_product(@cart.line_items.find(params[:id]))
     #the @cart is a security measure to ensure that the item is within
     # the current cart; I'm not certain if this is needed


    respond_to do |format|
      format.html { redirect_to store_url  }
      format.json { head :no_content }
    end
  end
end
