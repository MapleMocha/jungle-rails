require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'User Validation' do

    it 'should allow user when password matches confirmation' do
      @user = User.new(
        name: "Professor Plum",
        email: "profPlum@Clue.com",
        password: "itWasMe"
      )
      @user.save
      expect(@user).to be_present

    end

    it 'should require a unique email (not case sensitive)' do
      @user = User.new(
        name: "Professor Plum",
        email: "profPlum@Clue.com",
        password: "itWasMe",
        password_confirmation: "itWasMe"
      )
      @user.save

      @user2 = User.new(
        name: "Professor Plum",
        email: "PROFPlum@Clue.com",
        password: "itWasMe",
        password_confirmation: "itWasMe"
      )
      @user2.save
      expect(@user2.errors.full_messages).to include 'Email has already been taken'

    end

    it 'should require a name' do
      @user = User.new(
        email: "profPlum@Clue.com",
        password: "itWasMe"
      )
      @user.save
      expect(@user.errors.full_messages).to include "Name can't be blank"

    end

    it 'should require a password' do
      @user = User.new(
        name: "Professor Plum",
        email: "profPlum@Clue.com",
      )
      @user.save
      expect(@user.errors.full_messages).to include "Password can't be blank"

    end

    it 'should require a password of minimum length 6' do
      @user = User.new(
        name: "Professor Plum",
        email: "profPlum@Clue.com",
        password: "short"
      )
      @user.save
      expect(@user.errors.full_messages).to be_present

    end

    it 'should require an email' do
      @user = User.new(
        name: "Professor Plum",
        password: "itWasMe"
      )
      @user.save
      expect(@user.errors.full_messages).to include "Email can't be blank"

    end

  end

  describe '.authenticate_with_credentials' do
    # examples for this class method here
    before :each do
      @password = BCrypt::Password.create("itWasMe")
      @user = User.create!(
        name: "Professor Plum",
        email: "  proFPlum@clue.com  ",
        password: "itWasMe",
        password_confirmation: "itWasMe"
      )
    end

    it 'should find an existing user when credentials are correct' do
      search = User.find_by_email(@user.email)
      expect(@user).to eq(search)
    end

    it 'should find an existing user when credentials are correct - despite whitespaces' do
      search = User.find_by_email('profplum@clue.com')
      expect(@user).to eq(search)
    end

    it 'should not find an existing user in with incorret credentials' do
      search = User.find_by_email("notTheRight@email.com")
      expect(search).to be_nil
    end

  end

end
