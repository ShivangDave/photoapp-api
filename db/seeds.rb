Api::V1::User.destroy_all

u1 = Api::V1::User.create(
  username: 'test',
  password: 'test',
  profile_name: 'test',
  email: 'test@test.com',
  location: 'test'
)

# u2 = Api::V1::User.new(
#   username: 'test',
#   password: 'test',
#   profile_name: 'test',
#   email: 'test@test.com',
#   location: 'test'
# )
