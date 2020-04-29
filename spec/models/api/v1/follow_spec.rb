require 'rails_helper'

RSpec.describe Api::V1::Follow, type: :model do

  context 'Follow Model Tests' do
    let (:params)  { { username: 'test ', password: 'test', profile_name: 'test', email: 'test@test.com', location: 'test' } }
    let (:params2) { { username: 'test2', password: 'test', profile_name: 'test', email: 'test2@test.com', location: 'test' } }
    let (:params3) { { username: 'test3', password: 'test', profile_name: 'test', email: 'test3@test.com', location: 'test' } }
    let (:params4) { { username: 'test4', password: 'test', profile_name: 'test', email: 'test4@test.com', location: 'test' } }
    let (:params5) { { username: 'test5', password: 'test', profile_name: 'test', email: 'test5@test.com', location: 'test' } }
    
    before(:each) do
      u1 = Api::V1::User.new(params).save
      u2 = Api::V1::User.new(params2).save
      u3 = Api::V1::User.new(params3).save
      u4 = Api::V1::User.new(params4).save
      u5 = Api::V1::User.new(params5).save
    end

    it 'should get list of followers' do
      user = Api::V1::User.all.first
      user2 = Api::V1::User.all.second
      user3 = Api::V1::User.all.last
      user2.followers << user3

      expect(user.followers.length).to eq(0)
      expect(user2.followers.length).to eq(1)
    end

    it 'should get list of followees' do
      user = Api::V1::User.all.first
      user2 = Api::V1::User.all.second
      user3 = Api::V1::User.all.last
      user2.followers << user3

      expect(user.followees.length).to eq(0)
      expect(user3.followees.length).to eq(1)
    end

    it 'list of followers should have correct users in it' do
      user = Api::V1::User.all.first
      user2 = Api::V1::User.all.second
      user3 = Api::V1::User.all.last
      user2.followers << user3
      
      expect(user2.followers).to_not include(user)
      expect(user2.followers).to include(user3)
    end

    it 'list of followees should have correct users in it' do
      user = Api::V1::User.all.first
      user2 = Api::V1::User.all.second
      user3 = Api::V1::User.all.last
      user2.followers << user3
      
      expect(user3.followees).to_not include(user)
      expect(user3.followees).to include(user2)
    end

    it 'should only have valid users as followers' do
      user = Api::V1::User.all.first
      user2 = Api::V1::User.all.second
      user3 = Api::V1::User.all.last

      user.followers << user2
      user.followers << user3
      
      user2.destroy
      user.reload

      expect(user.followers.length).to eq(1)
      expect(user.followers).to_not include(user2)
      expect(user.followers).to include(user3)
    end

    it 'should only have valid users as followees' do
      user = Api::V1::User.all.first
      user2 = Api::V1::User.all.second
      user3 = Api::V1::User.all.last

      user.followers << user3
      user2.followers << user3
      
      user.destroy
      user3.reload
      
      expect(user3.followees.length).to eq(1)
      expect(user3.followees).to_not include(user)
      expect(user3.followees).to include(user2)
    end

  end

end
