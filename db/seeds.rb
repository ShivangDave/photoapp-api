Api::V1::User.destroy_all

def seed
  @u1 = Api::V1::User.create(
    username: 'test',
    password: 'test',
    profile_name: 'test',
    email: 'test@test.com',
    location: 'test'
  )

  @u2 = Api::V1::User.create(
    username: 'test2',
    password: 'test2',
    profile_name: 'test2',
    email: 'test2@test.com',
    location: 'test2'
  )

  @u1._id = JWT.encode({user_id: @u1.id},ENV['SUPER_SECRET_USER_KEY']).split('.').join('$')
  @u2._id = JWT.encode({user_id: @u2.id},ENV['SUPER_SECRET_USER_KEY']).split('.').join('$')
  
  @u1.save!
  @u2.save!
  
end

seed
