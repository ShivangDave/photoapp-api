require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
    
    before(:each) do
        
    end

    context 'Testing Application Controller Methods' do
        let (:user_params) { { "username": "test4", "password": "test", "profile_name": "test", "email": "test4@test.com", "location": "test" } }

        it 'expect 200 response on root path' do
            get :index
            expect(response.status).to eq(200)
            expect(response.body).to include("Photo API Home Page")
        end

        it 'current_user should return user instance' do
            user = Api::V1::User.create({ username: 'test ', password: 'test', email: 'test@test.com' })
            profile = user.profile
            request.headers['Access-Token'] = profile[:_id]

            a1 = ApplicationController.new
            a1.request = request
            
            begin
                return_val = a1.current_user
            rescue
                return_val = nil
            end
            
            expect(return_val).to eq(user)
            expect(return_val.id).to eq(user.id)
        end

        it 'current_user should return nil if there is no current_user' do     
            a1 = ApplicationController.new
            a1.request = request
            begin
                return_val = a1.current_user
            rescue
                return_val = nil
            end
            expect(return_val).to eq(nil)
        end
        
        it 'authenticate! should return user instance if there is a current_user' do
           
            user = Api::V1::User.create({ username: 'test ', password: 'test', email: 'test@test.com' })
            profile = user.profile
            request.headers['Access-Token'] = profile[:_id]
            
            a1 = ApplicationController.new
            a1.request = request
            
            begin
                return_val = a1.authenticate!
            rescue
                return_val = nil
            end

            expect(return_val).to eq(user)
            expect(return_val.id).to eq(user.id)
        end

        it 'authenticate! should return nil if there is no current_user' do     
            a1 = ApplicationController.new
            a1.request = request
            begin
                return_val = a1.authenticate!
            rescue
                return_val = nil
            end
            expect(return_val).to eq(nil)
        end
    end

end