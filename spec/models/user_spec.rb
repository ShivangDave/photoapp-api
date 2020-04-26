require 'rails_helper'

RSpec.describe Api::V1::User, :type => :model do

  subject {
    described_class.new(
      username: 'test',
      password: 'test',
      profile_name: 'test',
      email: 'test@test.com',
      location: 'test'
    )
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a username" do
    subject.username = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a password" do
    subject.password = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a profile_name" do
    subject.profile_name = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without an email" do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a location" do
    subject.location = nil
    expect(subject).to_not be_valid
  end

end
