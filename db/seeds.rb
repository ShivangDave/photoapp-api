Api::V1::User.destroy_all

def seed

  @u1 = Api::V1::User.create(
    username: 'test',
    password: 'test',
    email: 'test@test.com'
  )

  @u2 = Api::V1::User.create(
    username: 'test2',
    password: 'test2',
    email: 'test2@test.com'
  )

  @u3 = Api::V1::User.create(
    username: 'test3',
    password: 'test3',
    email: 'test3@test.com'
  )

  @u1.profile.followers << @u2.profile
  @u1.profile.followers << @u3.profile
  @u2.profile.followers << @u3.profile


  @p1 = @u1.profile.posts.build(caption: 'First Post', location: 'Atlanta, GA')
  @p1.save

  @p2 = @u2.profile.posts.build(caption: 'Second Post', location: 'Atlanta, GA')
  @p2.save
  
end

seed
