require 'rails_helper'

RSpec.describe Api::V1::Comment, type: :model do
  
  context "Comment body Validation" do
    
    it 'requires body for the comment' do
      user = Api::V1::User.create(username: 'test', password: 'test', email: 'test@test.com')
      profile = user.profile

      post = profile.posts.build(caption: 'First Post', location: 'Atlanta, GA')
      post.save

      comment = Api::V1::Comment.new()
      post = profile.create_comment.build(post: post, comment: comment)

      expect(post.save).to eq(false)
    end
    
    it 'comment persists with right parameters' do
      user = Api::V1::User.create(username: 'test', password: 'test', email: 'test@test.com')
      profile = user.profile

      post = profile.posts.build(caption: 'First Post', location: 'Atlanta, GA')
      post.save

      comment = Api::V1::Comment.create(body: 'Hello')
      post_comment = profile.create_comment.build(post: post, comment: comment)

      expect(post_comment.save).to eq(true)
      expect(post.profile).to eq(user.profile)
      expect(post.profile).to eq(post.comments.first.profile)
    end

  end

end
