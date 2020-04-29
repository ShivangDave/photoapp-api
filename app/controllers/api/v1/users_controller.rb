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
    @user.destroy
    secure_response({ :message => "Destroyed.." }, :ok)
  end

  def follow
    # @user.followers << #
  end

  def unfollow
    # @user.followers.filter
  end

  private
  def users_params
    if decode_request
      decode_request.require(:user).permit(:username,:password,:profile_name,:email,:location)
    end
  end

  def check_persistance
    if @user && @user.persisted?
      profile = @user.profile
      secure_response(profile, :ok)
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
