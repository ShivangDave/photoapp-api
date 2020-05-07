require 'rails_helper'

RSpec.describe Api::V1::Post, type: :model do
  
  context 'Post associations Test' do

    it 'Only create a post if media is attached' do
    end
    
    it 'Tests if posts persist' do
      user = Api::V1::User.create(username: 'test', password: 'test', email: 'test@test.com')
      profile = user.profile
      profile.posts.build(caption: 'Hello World').save

      expect(profile.posts.first).to_not eq(nil)
    end

    it 'Tests Post for correct Associations' do
      user = Api::V1::User.create(username: 'test', password: 'test', email: 'test@test.com')
      profile = user.profile
      profile.posts.build(caption: 'Hello World').save
      post = user.posts.first
      
      expect(post.profile).to eq(user.profile)
      expect(post.profile.user).to eq(user)
      expect(user.posts).to include(post)
      
    end
  end

end
