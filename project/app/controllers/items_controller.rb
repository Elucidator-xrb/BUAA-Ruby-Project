class ItemsController < ApplicationController
  before_action :set_item, only: %i[ show edit update destroy ]

  # GET /items or /items.json
  def index
    @items = Item.all
  end

  # GET /items/1 or /items/1.json
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items or /items.json
  def create
    @shoppinglist = Shoppinglist.find(params[:shoppinglist_id])
    @item = Item.new(item_params)
    @item.shoppinglist = @shoppinglist
    

    respond_to do |format|
      if @item.save
        @shoppinglist.total += @item.quantity * @item.product.price
        @shoppinglist.save  # 修改shoppinglist的total数
        format.html { redirect_to @shoppinglist, notice: "Item was successfully created." }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render "shoppinglists/show", status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1 or /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to item_url(@item), notice: "Item was successfully updated." }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1 or /items/1.json
  def destroy
    @shoppinglist = Shoppinglist.find(params[:shoppinglist_id])
    @shoppinglist.total -= @item.quantity * @item.product.price
    @item.destroy

    respond_to do |format|  # items_url -> shoppinglist_items_url -> current
      format.html { redirect_to @shoppinglist, notice: "Item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def item_params
      params.require(:item).permit(:shoppinglist_id, :product_id, :quantity)
    end
end
