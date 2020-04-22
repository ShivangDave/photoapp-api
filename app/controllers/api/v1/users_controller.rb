class Api::V1::UsersController < ApplicationController

  before_action :find_user, only: [:show, :update, :destroy]

  def index
    @users = Api::V1::User.all
    secure_response({ :users => @users.as_json }, :ok)
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
      secure_response("Destroyed..", :ok)
    else
      secure_response("Failed..", :not_found)
    end
  end

  private
  def users_params
    params.require(:user).permit(:username,:password,:profile_name,:email,:location)
  end

  def secure_response(packet, status)
    msg = JWT.encode(packet,ENV['SUPER_SECRET_USER_KEY'])
    render :json => { :message => msg }, :status => status
  end

  def check_persistance
    if @user.persisted?
      secure_response(@user.profile, :ok)
    else
      secure_response(@user.errors.details, :bad_request)
    end
  end

  def find_user
    @user = Api::V1::User.find_by(id: params[:id])
  end
end
