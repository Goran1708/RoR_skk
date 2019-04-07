require 'rails_helper'

RSpec.describe User, type: :model do
  it "is not valid if password and password conf do not match" do
    user = User.new(email: "email@email.com", password: "111111", password_confirmation: "1111111")
    expect(user).to_not be_valid
  end

  it "is not valid if email is not unique" do
    User.create(email: "email@email.com", password: "111111", password_confirmation: "111111")
    user = User.new(email: "email@email.com", password: "111111", password_confirmation: "111111")
    expect(user).to_not be_valid
  end

  it "is not valid if email is not unique" do
    User.create(email: "email@email.com", password: "111111", password_confirmation: "111111")
    user = User.new(email: "email@email.com", password: "111111", password_confirmation: "111111")
    expect(user).to_not be_valid
  end

  it "is not valid if user does not have first and last name" do
    user = User.new(email: "email@email.com", password: "111111", password_confirmation: "111111")
    expect(user).to_not be_valid
  end

  it "email is invalid" do
    user = User.new(email: "email", password: "111111", password_confirmation: "111111", first_name: "First", last_name: "Last")
    expect(user).to_not be_valid
  end

  it "is valid" do
    user = User.new(email: "email@email.com", password: "111111", password_confirmation: "111111", first_name: "First", last_name: "Last")
    expect(user).to be_valid
  end
end
