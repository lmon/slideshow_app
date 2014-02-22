require 'spec_helper'

describe "User Pages" do
  subject { page }

  describe "signup page" do
    before { visit signup_path }

    it { should have_content('Sign up') }
    it { should have_title( 'Sign up' ) }
  end

  describe "profile page" do
  	let(:user) { FactoryGirl.create(:user) }
  	before { visit user_path(user) }

  	it { should have_content(user.name) }
  	it { should have_title(user.name) }
	end

  # list users 
  describe "index" do
    # create some temp users
    describe "with a logged in user" do
      before do
        sign_in FactoryGirl.create(:user)
        FactoryGirl.create(:user, name: "Bob", email: "bob@example.com")
        FactoryGirl.create(:user, name: "Ben", email: "ben@example.com")
        visit users_path
      end
      
      it { should have_selector('div table thead tr th', text: 'Name') }
      it { should have_content('Listing') }

      it "should list each user" do
        User.all.each do |user|
          expect(page).to have_selector('li', text: user.name)
        end
      end
    end
    #describe "with a logged in user" do
    #  before { visit signin_path }

     # let(:user) {FactoryGirl.create(:user) }
      #  before do
       #   fill_in "Email",        with: user.email.upcase
        #  fill_in "Password",     with: user.password
         # click_button 'Sign in' 
        #end
      #before { visit users_path }
  
      #it { should have_selector('div table thead tr th', text: 'Name') }
    #end
    
    describe "with a logged out user" do
      before { visit users_path }
      it { should have_selector('div', text: 'Sign in') }
    end

    describe "visiting the index listing page only as Admin-type" do
      pending
    end
    describe "visiting the index listing page only as NON Admin-type" do
      pending
    end
  end

# edit a user 
  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end

      describe "page" do
        it{should have_content('Update your profile')}
        it{should have_title('Edit user')}
        it{should have_link('change'), href: 'http://gravatar.com/emails'}
      end

      describe "with invalid information" do
        before { click_button "Save changes" }
        it { should have_content('error') }
      end

      describe "with valid information" do
          let(:new_name)  { "New Name" }
          let(:new_email) { "new@example.com" }
          before do
            fill_in "Name",             with: new_name
            fill_in "Email",            with: new_email
            fill_in "Password",         with: user.password
            fill_in "Confirm Password", with: user.password
            click_button "Save changes"
          end

          it { should have_title(new_name) }
          it { should have_selector('div.alert.alert-success') }
          it { should have_link('Sign out', href: signout_path) }
          specify { expect(user.reload.name).to  eq new_name }
          specify { expect(user.reload.email).to eq new_email }
      end

  end

  describe "delete user page" do
    pending
  end

########## Signup
describe "signup" do

    before { visit signup_path }

    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }

        it { should have_link('Sign out') }
        it { should have_title(user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
      end
      
    end
  end
  
end
