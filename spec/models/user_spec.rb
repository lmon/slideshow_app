require 'spec_helper'

describe User do

  before { @user = User.new(name: "Example User", email: "user@example.com") }

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }

  it { should be_valid }

  describe "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @user.name = "a" * 65 }
    it { should_not be_valid }
  end

  describe "when name is too short" do
    before { @user.name = "a"  }
    it { should_not be_valid }
  end

  describe "when email is too long" do
    before { @user.email = "a" * 65 }
    it { should_not be_valid }
  end

  describe "when email is too short" do
    before { @user.email = "a"  }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end

  describe "when email is not unique" do
   	#pending "validate uniqueness of email" 
	before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
   end

    it { should_not be_valid }
  end

end
