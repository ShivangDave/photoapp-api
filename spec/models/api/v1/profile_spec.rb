require 'rails_helper'

RSpec.describe Api::V1::Profile, type: :model do
  
  context 'Profile Validations Tests' do  

    it 'ensures profile has an unique _id & slug ' do
      
      user = Api::V1::User.create(username: 'test', password: 'test', email: 'test@test.com')
      u1 = user.profile

      user2 = Api::V1::User.create(username: 'test2', password: 'test2', email: 'test2@test.com')
      u2 = user2.profile

      expect(u1._id).to_not eq(u2._id)
      expect(u1.slug).to_not eq(u2.slug)
    end

    it 'ensures user has a password' do
      user = Api::V1::User.create(username: 'test', password: 'test', email: 'test@test.com')
      u1 = user.profile

      expect(u1.profile_name).to_not eq(nil)
    end
  end
end
