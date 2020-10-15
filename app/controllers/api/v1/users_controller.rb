class Api::V1::UsersController < ApplicationController
  before_action :authorized, only: [:show, :index, :update, :destroy]
  before_action :correct_user, only: [:show, :update, :destroy]
  before_action :isadmin?, only: [:index]

  # SHOW USER BY ID api/v1/users/<id>
  def show
    begin
      user = User.find(params[:user_id])
      render json: { user: user }, status: :ok
    rescue
      render json: { errors: e.message}, status: 404
    end
  end

  # INDEX ALL USERS GET api/v1/users
  def index
    users = User.all
    render json: { users: users }, status: :ok
  end

  # DELETE USER DELETE api/v1/users/<id>
  def destroy
    begin
      user = User.find(params[:user_id])
      if user.destroy
        render json: { user: user }, status: 204
      else
        render json: { errors: user.errors.messages }, status: 422
      end
    rescue => e
      render json: { errors: e.message }, status: 404
    end
  end

  #UPDATE USER PUT api/v1/users/<id>
  def update
    begin
      user = User.find(params[:user_id])
      if user.update(user_params)
        render json: user, status: :ok
      else
        render json: { errors: user.errors.messages }, status: 422
      end
    rescue => e
      render json: { errors: e.message }, status: 404
    end
  end

  #POST api/v1/signup
  def create
    user = User.new(user_params)
    if user.save
      token = encode_token({user_id: user.id})
      render json: {user: user, token: token}, status: :created
    else
      render json: { errors: user.errors.messages }, status: 422
    end
  end

  #POST api/v1/login
  def login
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      token = encode_token({user_id: user.id})
      puts token
      render json: {user: user, token: token}, status: :ok
    else
      render json: { errors: "Invalid username or password" }, status: :unauthorized #401
    end
  end

  private

  def user_params
    params.permit(:email, :password, :full_name, :cellphone)
  end

end
