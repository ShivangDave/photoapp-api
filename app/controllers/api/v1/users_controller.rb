class Api::V1::UsersController < ApplicationController

  before_action :find_user, only: [:show, :update, :destroy]

  def index
    @users = Api::V1::User.profiles
    secure_response({ :users => @users }, :ok)
  end

  def show
    check_persistance
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
      secure_response({ :message => "Destroyed.." }, :ok)
    else
      secure_response({ :message => "Failed.." }, :not_found)
    end
  end

  private
  def users_params
    decode_params.require(:user).permit(:username,:password,:profile_name,:email,:location)
  end

  def check_persistance
    if @user && @user.persisted?
      secure_response(@user.profile, :ok)
    else
      if @user.nil?
        secure_response({ :message => "Something went wrong.."}, :bad_request)
      else
        secure_response(@user.errors.details, :bad_request)
      end
    end
  end

  def find_user
    @user = Api::V1::User.find_by(id: params[:id])
  end
end
