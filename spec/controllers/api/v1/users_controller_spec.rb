require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  
  context 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response.status).to eq(200)
      expect(response.body).to include("message")
    end

    it 'returns an encoded message' do
      get :index
      expect(response.status).to eq(200)
      expect(response.body["message"]).to_not include("users")
    end

    it 'returns an encrypted list of users' do
      get :index
      packet = JSON.parse(response.body)["message"]
      begin
        message = JWT.decode(packet,ENV['SUPER_SECRET_USER_KEY'])[0]
      rescue
        message = nil
      end
      expect(response.status).to eq(200)
      expect(message).to_not eq(nil)
      expect(message).to include("users")
      expect(message["users"].class).to eq(Array)
    end

    it 'response should only be able to be decoded using the right key' do
      get :index
      packet = JSON.parse(response.body)["message"]
      begin
        message = JWT.decode(packet,'Yo ssup?')
      rescue
        message = nil
      end      
      expect(response.status).to eq(200)
      expect(message).to eq(nil)
    end

  end

  context 'GET #show' do
    it 'returns a 200 for valid request' do
      user = Api::V1::User.create({ username: 'test ', password: 'test', email: 'test@test.com' })
 
      get :show, params: { id: user.profile.slug }
      
      packet = JSON.parse(response.body)["message"]
      begin
        message = JWT.decode(packet,ENV['SUPER_SECRET_USER_KEY'])[0]
      rescue
        message = nil
      end

      expect(response.status).to eq(200)
      expect(response.body).to include("message")
      expect(message).to include("username")
      expect(message["username"]).to eq(user.username)
    end
    
    it 'returns a 400 (bad request) for invalid request' do
      get :show, params: { id: 'some_random_param' }

      expect(response.status).to eq(400)
      expect(response.body).to include("message")
    end
  end

  context 'POST #create' do
      
    let (:user_params) { { "username": "test4", "password": "test", "email": "test4@test.com" } }

    it 'returns a 200 for valid request' do
      post :create, params: { "_json": JWT.encode({ "user": user_params }, ENV['SUPER_SECRET_USER_KEY'] )}
      
      expect(response.status).to eq(200)
      expect(response.body).to include("message")
    end

    it 'creates new user' do
      post :create, params: { "_json": JWT.encode({ "user": user_params }, ENV['SUPER_SECRET_USER_KEY'] )}
      
      packet = JSON.parse(response.body)["message"]  
      begin
        message = JWT.decode(packet,ENV['SUPER_SECRET_USER_KEY'])[0]
      rescue
        message = nil
      end

      expect(response.status).to eq(200)
      expect(message).to include("_id")
      expect(message).to include("username")
      expect(message).to include("email")
      expect(message).to include("profile_name")
      expect(message).to include("location")
      expect(message).to include("followers")
      expect(message).to include("followees")

      expect(message["username"]).to eq(user_params[:username])
      expect(message["email"]).to eq(user_params[:email])
      expect(message["profile_name"]).to eq(user_params[:profile_name])
      expect(message["location"]).to eq(user_params[:location])
    end

    it 'returns a 400 (bad request) for invalid request' do
      post :create, params: { }

      expect(response.status).to eq(400)
      expect(response.body).to include("message")
    end
    
  end

  context 'PATCH #update' do   
    let (:user_params) { { "username": "test4", "password": "test", "email": "test4@test.com" } }

    it 'returns a 200 for valid request' do
      user = Api::V1::User.create({ username: 'test ', password: 'test', email: 'test@test.com' })
      patch :update, params: { id: user.id, "_json": JWT.encode({ "user": user_params }, ENV['SUPER_SECRET_USER_KEY'] ) }
    
      packet = JSON.parse(response.body)["message"]  
      begin
        message = JWT.decode(packet,ENV['SUPER_SECRET_USER_KEY'])[0]
      rescue
        message = nil
      end
      expect(response.status).to eq(200)
      expect(message["username"]).to eq(user_params[:username])
      expect(message["profile_name"]).to eq(user_params[:profile_name])
      expect(message["email"]).to eq(user_params[:email])
      expect(message["location"]).to eq(user_params[:location])
    end

  end

  context 'DELETE #destroy' do
      
    let (:user_params) { { "username": "test4", "password": "test", "email": "test4@test.com" } }

    it 'deletes a user' do
      user = Api::V1::User.create({ username: 'test ', password: 'test', email: 'test@test.com' })
          
      delete :destroy, params: { id: user.profile.slug }

      packet = JSON.parse(response.body)["message"]  
      begin
        message = JWT.decode(packet,ENV['SUPER_SECRET_USER_KEY'])[0]
      rescue
        message = nil
      end

      expect(response.status).to eq(200)
      expect(message).to include("message")
      expect(message["message"]).to eq("Destroyed..")
    end
  end
end
