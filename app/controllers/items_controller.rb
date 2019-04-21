class ItemsController < ApplicationController
  before_action :find_item, only: %i[show edit update delete complete]

  def index
    if user_signed_in?
      @items = Item.where(user_id: current_user_id).order("created_at DESC")
  end

  def new
    @item = current_user.items.build
  end

  def create
    @item = current_user.items.build(item_params)

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

  def complete
    @item.update_attribute(:completed_at, Time.now)
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
