## Photoapp API

## Features

- Create User Profiles 
    - Allow: Username, Profile Name, Location, Email
    - Allow: Set an avatar
    - Allow: Follow, Unfollow
    - Allow: Delete Profile

- Create Posts
    - Allow: Caption, Image(s), Video(s), Location
    - Allow: Likes, Comments
    - Allow: Edit Caption, Delete Post

- TBD

## Routes
### Status Code

- Done - ✅
- WIP - 💥
- Coming soom - ❌

### Users ✅
| Type | Auth | Routes | Status | 
|-|-|-|-|
| GET | required | /users | ✅ |
| POST | - | /users/create | ✅ |
| GET | required | /users/:id | ✅ |
| POST | required | /users/:id/follow | ✅ |
| POST | required | /users/:id/unfollow | ✅ |
| DELETE | required | /users/:id | ✅ |

### Posts 💥
| Type | Auth | Routes | status | 
|-|-|-|-|
| GET | required | /posts | ❌ |
| POST | required | /posts/create | ❌ |
| GET | required | /posts/:id | ❌ |
| POST | required | /posts/:id/like | ❌ |
| POST | required | /posts/:id/unlike | ❌ |
| POST | required | /posts/:id/comment | ❌ |
| DELETE | required | /posts/:id | ❌ |


### TBD