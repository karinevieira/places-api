class Api::PlacesController < ApplicationController
  include Authenticable

  before_action :authenticate_with_token
  before_action :set_place, only: [:show, :update, :destroy]

  # GET /places
  def index
    @places = Place.by_token(@token).search(params[:name]).sorted_by_name

    render json: @places
  end

  # GET /places/1
  def show
    render json: @place
  end

  # POST /places
  def create
    @place = Place.new(place_params.to_h.merge!({ token: @token }))

    if @place.save
      render json: @place, status: :created, location: api_place_url(@place)
    else
      render json: @place.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /places/1
  def update
    if @place.update(place_params)
      render json: @place
    else
      render json: @place.errors, status: :unprocessable_entity
    end
  end

  # DELETE /places/1
  def destroy
    @place.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_place
      @place = Place.by_token(@token).find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def place_params
      params.require(:place).permit(:name, :city, :state)
    end
end
