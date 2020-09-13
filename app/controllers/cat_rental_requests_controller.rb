class CatRentalRequestsController < ApplicationController
  before_action :require_current_user
  before_action :user_must_own_cat, only: [:approve, :deny]

  def new
    @cat_rental_request = CatRentalRequest.new
    render :new
  end

  def create
    @cat_rental_request = CatRentalRequest.new(cat_rental_request_params)
    @cat_rental_request.requester = current_user
    if @cat_rental_request.save
      redirect_to cat_rental_request_url(@cat_rental_request)
    else
      flash.now[:errors] = @cat_rental_request.errors.full_messages
      render :new
    end
  end

  def show
    @cat_rental_request = CatRentalRequest.find_by(id: params[:id])
    render :show
  end

  def approve
    # @cat_rental_request = CatRentalRequest.find_by(id: params[:id])
    @cat_rental_request.approve!
    redirect_to cat_url(@cat_rental_request.cat_id)
  end

  def deny
    # @cat_rental_request = CatRentalRequest.find_by(id: params[:id])
    @cat_rental_request.deny!
    redirect_to cat_url(@cat_rental_request.cat_id)
  end

  def user_must_own_cat
    # overrides method in ApplicationController
    @cat_rental_request = CatRentalRequest.find_by(id: params[:id])
    redirect_to cats_url unless @cat_rental_request.cat_owner == current_user
  end

  private

  def cat_rental_request_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
  end
end