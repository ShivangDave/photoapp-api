class Api::V1::UsersController < ApplicationController

  before_action :find_user, only: [:show, :destroy]

  def index
    @users = Api::V1::User.all
    render :json => @users, :status => :ok
  end

  def create
    @user = Api::V1::User.create(users_params)
    if @user.valid?
      render :json => @user, :status => :created
    else
      # @error = { "error": "failed to create user.."}
      render :json => @user.error.details, :status => :bad_request
    end
  end

  def update
  end

  def destroy
  end

  private
  def users_params
  end

  def find_user
    @user = Api::V1::User.find_by(id: params[:id])
  end
end
