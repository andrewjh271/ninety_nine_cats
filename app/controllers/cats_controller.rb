class CatsController < ApplicationController
  before_action :require_current_user, only: [:new, :edit, :create, :update]
  before_action :user_must_own_cat, only: [:edit, :update, :destroy]

  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find_by(id: params[:id])
    # @rental_requests = CatRentalRequest.where(cat_id: @cat.id).order(:start_date)
    # moved to view
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = Cat.new(cat_params)
    @cat.owner = current_user
    if @cat.save
      redirect_to cat_url(@cat)
    else
      render :new
    end
  end

  def edit
    # @cat is set in :user_must_own_cat callback
    render :edit
  end

  def update
    # @cat is set in :user_must_own_cat callback
    if @cat.update(cat_params)
      redirect_to cat_url(@cat)
    else
      render :edit
    end
  end

  def destroy
    # @cat is set in :user_must_own_cat callback
    @cat.destroy
    redirect_to cats_url
  end

  private

  def cat_params
    params.require(:cat).permit(:birthdate, :color, :name, :sex, :description)
  end

end