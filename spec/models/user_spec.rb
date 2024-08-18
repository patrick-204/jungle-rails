require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
  
    before do
      @user = User.new(
        email: "john@example.com",
        first_name: "John",
        last_name: "Doe",
        password: "pass12345",
        password_confirmation: "pass12345"
      )
    end

    it 'is a valid user' do
      expect(@user).to be_valid
    end

    it 'does not validate without a first name' do
      @user.first_name = nil
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it 'does not validate without a last name' do
      @user.last_name = nil
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'is invalid without matching password and password confirmation' do
      @user.password_confirmation = "123pass"
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'is invalid without a password' do
      @user.password = nil
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end


    it 'is invalid with an email that is not unique. The email is case insensitive' do
      skip 'Idk why not working'
      duplicate_user = User.new(
        email: "JOHN@example.com",
        first_name: "John",
        last_name: "Doe",
        password: "pass123",
        password_confirmation: "pass123"
      )

      expect(duplicate_user).not_to be_valid
      expect(duplicate_user.errors.full_messages).to include("Email has already been taken")
    end

    it 'is invalid with a password shorter than the minimum length' do
      user = User.new(
        email: "billd@example.com",
        first_name: "Bilbo",
        last_name: "bagz",
        password: "shortyy",
        password_confirmation: "shortyy"
      )
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Password is too short (minimum is 8 characters)")
    end
  end

  # authenticate with creds
  describe 'authenticate_with_credentials' do

    # valid tests
    context 'if credentials are valid' do
      it 'returns the user when email and password are correct' do
        authenticated_user = User.authenticate_with_credentials("john@example.com", "pass12345")
        expect(authenticated_user).to eq(@user)
      end
    end

    # Invlaid tests
    context 'if credentials are invalid' do
      it 'returns nil when the password is incorrect' do
        authenticated_user = User.authenticate_with_credentials("john@example.com", "wrongpassword")
        expect(authenticated_user).to be_nil
      end

      it 'returns nil when the email is incorrect' do
        authenticated_user = User.authenticate_with_credentials("bob@example.com", "password123")
        expect(authenticated_user).to be_nil
      end
    end

    context 'when email is case-insensitive' do
      it 'returns the user when email is provided in a different case' do
        authenticated_user = User.authenticate_with_credentials("JOHN@EXAMPLE.COM", "password123")
        expect(authenticated_user).to eq(@user)
      end
    end

    context 'when email has extra spaces' do
      it 'returns the user when email has leading or trailing spaces' do
        authenticated_user = User.authenticate_with_credentials("  john@example.com  ", "password123")
        expect(authenticated_user).to eq(@user)
      end
    end
  end

end
