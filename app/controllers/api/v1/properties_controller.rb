class Api::V1::PropertiesController < ApplicationController

  before_action :authorized, only: [:show, :create, :index, :update, :destroy]
  before_action :correct_user, only: [:show, :create, :index, :update, :destroy]

  #GET /api/v1/users/<id>/properties/
  def index
    begin
      user = User.find(params[:user_id])
      if user.isadmin
        properties = Property.all
      else
        properties = user.properties
      end
      render json: { properties: properties }, status: :ok
    rescue => e
      render json: { error: e.message }, status: 404
    end
  end

  #GET /api/v1/users/:user_id/properties/:property_id
  def show
    begin
      property = Property.find(params[:property_id])
      render json: { properties: property }, status: :ok
    rescue => e
      render json: { errors: e.message }, status: 404
    end
  end

  #DELETE /api/v1/users/:user_id/properties/<property_id>
  def destroy
    begin
      property = Property.find(params[:property_id])
      if property.destroy
        render json: {}, status: :ok
      else
        render json: { errors: property.errors.messages }, status: 422
      end
    rescue => e
      render json: { errors: e.message }, status: 404
    end
  end

  def update
  end

  #POST /api/v1/users/<id>/properties/
  def create
    begin
      puts params
      user = User.find(params[:user_id])
      property = Property.new(property_params)
      if property.save
        render json: property, status: :ok
      else
        render json: { errors: property.errors.messages }, status: 422
      end
    rescue => e
      render json: { errors: e.message }, status: 404
    end
  end

  # UPDATE PROPERTY PUT api/v1/properties/<property_id>
  def update
    property = Property.find(params[:id])
    if property.update(propety_params)
      render json: property, status: :ok
    else
      render json: { errors: property.errors }, status: 422
    end
  end

  private

  def property_params
    params.permit(:built_type, :city, :price, :address, :admon, :build_area,
                  :private_area, :social_class, :state, :elevator, :common_areas,
                  :property_tax, :rooms, :bathrooms, :half_bathrooms, :parking_lot,
                  :utility_room, :empty_property, :inhabitants, :rent, :morgage,
                  :user_id)
  end

end
