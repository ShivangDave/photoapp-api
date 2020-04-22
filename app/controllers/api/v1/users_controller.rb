class Api::V1::UsersController < ApplicationController

  before_action :find_user, only: [:show, :update, :destroy]
  # after_action :check_persistance, only: [:create, :update]

  def index
    @users = Api::V1::User.all
    if @users
      render :json => @users, :status => :ok
    else
      render :json => @users.error.details, :status => :not_found
    end
  end

  def create
    @user = Api::V1::User.create(users_params)
    check_persistance
  end

  def update
    @user.update(users_params)
    check_persistance
  end

  def destroy
    if @user
      @user.destroy
      render :json => { :message => "Destroyed.." }, :status => :ok
    else
      render :json => { :message => "Failed.." }, :status => :not_found
    end
  end

  private
  def users_params
    params.require(:user).permit(:username,:password,:profile_name,:email,:location)
  end

  def check_persistance
    if @user.persisted?
      render :json => @user, :status => :ok
    else
      render :json => @user.errors.details, :status => :bad_request
    end
  end

  def find_user
    @user = Api::V1::User.find_by(id: params[:id])
  end
end
