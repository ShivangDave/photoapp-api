require 'rails_helper'

 # subject {
  #   described_class.new(
  #     username: 'test',
  #     password: 'test',
  #     profile_name: 'test',
  #     email: 'test@test.com',
  #     location: 'test'
  #   )
  # }

RSpec.describe Api::V1::User, :type => :model do

  context 'User Validations Tests' do
    
    it 'ensures user has a username' do
      user = Api::V1::User.new(password: 'test',profile_name: 'test', email: 'test@test.com', location: 'test').save
      expect(user).to eq(false)
    end

    it 'ensures user has a password' do
      user = Api::V1::User.new(username: 'test', profile_name: 'test', email: 'test@test.com', location: 'test').save
      expect(user).to eq(false)
    end

    it 'ensures user has a profile_name' do
      user = Api::V1::User.new(username: 'test', password: 'test', email: 'test@test.com', location: 'test').save
      expect(user).to eq(false)
    end

    it 'ensures user has an email' do
      user = Api::V1::User.new(username: 'test', password: 'test', profile_name: 'test', location: 'test').save
      expect(user).to eq(false)
    end

    it 'ensures user has correct syntax for an email' do
      user = Api::V1::User.new(username: 'test', password: 'test', email: 'test@test.com', profile_name: 'test', location: 'test').save
      expect(user).to eq(true)
    end

    it 'ensures user has a location' do
      user = Api::V1::User.new(username: 'test', password: 'test',profile_name: 'test', email: 'test@test.com').save
      expect(user).to eq(false)
    end

    it 'should save' do
      user = Api::V1::User.new(username: 'test', password: 'test',profile_name: 'test', email: 'test@test.com', location: 'test').save
      expect(user).to eq(true)
    end

    it 'username should be unique' do
      user = Api::V1::User.new(username: 'test', password: 'test', profile_name: 'test', email: 'test@test.com', location: 'test').save
      user2 = Api::V1::User.new(username: 'test', password: 'test', profile_name: 'test', email: 'test@test.com', location: 'test').save
      expect(user).to eq(true)
      expect(user2).to eq(false)
    end

    it 'email should be unique' do
      user = Api::V1::User.new(username: 'test', password: 'test', profile_name: 'test', email: 'test@test.com', location: 'test').save
      user2 = Api::V1::User.new(username: 'test2', password: 'test', profile_name: 'test', email: 'test@test.com', location: 'test').save
      expect(user).to eq(true)
      expect(user2).to eq(false)
    end
  end

  context 'User ActiveRecord & Scope Tests' do
    let (:params)  { { username: 'test ', password: 'test', profile_name: 'test', email: 'test@test.com', location: 'test' } }
    let (:params2) { { username: 'test2', password: 'test', profile_name: 'test', email: 'test2@test.com', location: 'test' } }
    let (:params3) { { username: 'test3', password: 'test', profile_name: 'test', email: 'test3@test.com', location: 'test' } }
    let (:params4) { { username: 'test4', password: 'test', profile_name: 'test', email: 'test4@test.com', location: 'test' } }
    let (:params5) { { username: 'test5', password: 'test', profile_name: 'test', email: 'test5@test.com', location: 'test' } }
    
    before(:each) do
      Api::V1::User.new(params).save
      Api::V1::User.new(params2).save
      Api::V1::User.new(params3).save
      Api::V1::User.new(params4).save
      Api::V1::User.new(params5).save
    end

    it 'should list all the users' do
      expect(Api::V1::User.all.length).to eq(5)
    end

    it 'should be able to find the user by the id' do
      user1 = Api::V1::User.all.sample
      expect(Api::V1::User.find_by(id: user1.id)).to eq(user1)
    end

    it 'should get back list of all user profiles' do
      users = Api::V1::User.profiles
      expect(users.class).to eq(Array)
      expect(users.length).to eq(5)
    end

    it 'should get back profile Hash' do
      user1 = Api::V1::User.all.sample
      profile = user1.profile

      expect(profile.class).to be(Hash)
    end

    it 'profile hash should have _id' do
      user1 = Api::V1::User.all.sample
      profile = user1.profile
      expect(profile).to include(:_id)
    end

    it 'profile hash should have an encoded id' do
      user1 = Api::V1::User.all.sample
      profile = user1.profile
      encoded_id = JWT.encode({ user_id: user1.id },ENV['SUPER_SECRET_USER_KEY'])

      expect(profile[:_id]).to_not eq(user1.id)
      expect(profile[:_id]).to eq(encoded_id)
    end
    
    it 'profile hash encoded id can be decoded' do
      user1 = Api::V1::User.all.sample
      profile = user1.profile
      decoded_id = JWT.decode(profile[:_id],ENV['SUPER_SECRET_USER_KEY'])[0]["user_id"]

      expect(profile[:_id]).to_not eq(user1.id)
      expect(user1.id).to eq(decoded_id)
    end

    
    
    it 'profile hash should have username' do
      user1 = Api::V1::User.all.sample
      profile = user1.profile
      expect(profile).to include("username")
    end
    
    it 'profile hash should have profile_name' do
      user1 = Api::V1::User.all.sample
      profile = user1.profile

      expect(profile).to include("profile_name")
    end
    
    it 'profile hash should have location' do
      user1 = Api::V1::User.all.sample
      profile = user1.profile

      expect(profile).to include("location")
    end
    
    it 'profile hash should have followers' do
      user1 = Api::V1::User.all.sample
      profile = user1.profile

      expect(profile).to include("followers")
    end
    
    it 'profile hash should have followees' do
      user1 = Api::V1::User.all.sample
      profile = user1.profile

      expect(profile).to include("followees")
    end

  end

end
