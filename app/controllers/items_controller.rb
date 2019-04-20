class ItemsController < ApplicationController
  before_action :find_item, only: %i[show edit update delete]

  def index
    @items = Item.all.order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)

    redirect_to item_path(@item) if @item.save

    render 'new'
  end

  def show
  end

  def edit
  end

  def update
    redirect_to item_path(@item) if @item.update(item_params)

    render 'edit'
  end

  def delete
    @item.destroy
    redirect_to root_path
  end

  private

  def find_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:title, :description)
  end
end
