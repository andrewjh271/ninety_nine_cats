class CatRentalRequestsController < ApplicationController
  def new
    @cat_rental_request = CatRentalRequest.new
    render :new
  end

  def create
    @cat_rental_request = CatRentalRequest.new(cat_rental_request_params)
    if @cat_rental_request.save
      redirect_to cat_rental_request_url(@cat_rental_request)
    else
      render :new
    end
  end

  def show
    @cat_rental_request = CatRentalRequest.find_by(id: params[:id])
    @cat = Cat.find_by(id: @cat_rental_request.cat_id)
    render :show
  end

  private

  def cat_rental_request_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
  end
end