class LineItemsController < ApplicationController
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
      logger.error "Attempt to access invalid lineItem #{params[:id]}"
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
    @cart = current_cart
    product = Product.find(params[:product_id])  #The params object is important inside Rails applications.
    #It holds all of the parameters passed in a browser request
    @line_item = @cart.add_product(product.id)

    session[:counter] = 0

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to(@line_item.cart,
                                  :notice => 'Line item was successfully created.') }
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

    @line_item = LineItem.find(params[:id])
    logger.info "destroy line item : #{params[:id]}"
    @line_item.destroy

    respond_to do |format|
      format.html { redirect_to current_cart }
      format.json { head :no_content }
    end
  end
end
