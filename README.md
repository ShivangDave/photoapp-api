## Photoapp API

### Latest Build (Production)
[Link](https://photoapp-api.herokuapp.com/)

[![Build Status](https://travis-ci.com/ShivangDave/photoapp-api.svg?branch=master)](https://travis-ci.com/ShivangDave/photoapp-api)

## Features
- E2EE ✅
    - Allow: End to End Encryption ✅
    - Allow: Abstract and Encrypt key in ENV ✅
    - Don't: Sharing keys with each packet ✅ 
    - Stretch: Setup a trusty && secure middleware to bounce requests ❌

- Create User Profiles 
    - Allow: Username, Profile Name, Location, Email ✅
    - Allow: Set an avatar
    - Allow: Follow, Unfollow ✅
    - Allow: Delete Profile ✅

- Create Posts
    - Allow: Caption, Image(s), Video(s), Location
    - Allow: Likes, Comments
    - Allow: Edit Caption, Delete Post

- Unit Tests ✅
    - 100% Code Coverage ✅

- Automated Builds CI/CD ✅
    - Docker ✅
    - Travis CI ✅
    - Heroku CD (Free tier dyno) ✅

- TBD

## Stack

- Backend: Ruby on Rails
- Unit Tests (API): RSpec
- Frontend: React, GraphQL
- Storage: Google Cloud
- Virtualization: Docker Container
- CI: Travis CI
- CD: Heroku

## Status Code

- Done - ✅
- WIP - 💥
- Coming soom - ❌

## Routes

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

### Unit Tests

| Progress | Name | Type | Status | 
|-|-|-|-|
| 100% | User | Model | ✅ |
| 100% | Follow | Model | ✅ |
| 100% | Application | Controllers | ✅ |
| 100% | Users | Controllers | ✅ |
| 0% | TBD | TBD | 💥 |

### TBD