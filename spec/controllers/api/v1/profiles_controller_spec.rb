require 'rails_helper'

RSpec.describe Api::V1::ProfilesController, type: :controller do

    context 'GET #index' do
        it 'returns a success response' do
          get :index
          expect(response.status).to eq(200)
          expect(response.body).to include("message")
        end
    end

    context 'PATCH #update' do   
      let (:profile_params) { { location: 'Houston', profile_name: 'Test' } }

      it 'returns a 200 for valid request' do
        user = Api::V1::User.create({ username: 'test ', password: 'test', email: 'test@test.com' })
        patch :update, params: { id: user.id, "_json": JWT.encode({ "profile": profile_params }, ENV['SUPER_SECRET_USER_KEY'] ) }
      
        packet = JSON.parse(response.body)["message"]  
        begin
          message = JWT.decode(packet,ENV['SUPER_SECRET_USER_KEY'])[0]
        rescue
          message = nil
        end
        expect(response.status).to eq(200)
        expect(message["profile_name"]).to eq(profile_params[:profile_name])
        expect(message["location"]).to eq(profile_params[:location])
      end

      it 'returns a 400 (bad request) for invalid request' do
        user = Api::V1::User.create({ username: 'test ', password: 'test', email: 'test@test.com' })
        patch :update, params: { id: "", "_json": JWT.encode({ "profile": profile_params }, ENV['SUPER_SECRET_USER_KEY'] ) }
        
        packet = JSON.parse(response.body)["message"]  
        begin
          message = JWT.decode(packet,ENV['SUPER_SECRET_USER_KEY'])[0]
        rescue
          message = nil
        end
        
        expect(response.status).to eq(400)
        expect(response.body).to include("message")
      end

  end

end
