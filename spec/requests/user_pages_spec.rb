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
    # for gallery
    let!(:m1) { FactoryGirl.create(:gallery, user: user, title: "Foo") }
    let!(:m2) { FactoryGirl.create(:gallery, user: user, title: "Bar") }
    
    before { visit user_path(user) }

  	it { should have_content(user.name) }
  	it { should have_title(user.name) }

    # for gallery
    describe "galleries" do
      it { should have_content(m1.title) }
      it { should have_content(m2.title) }
      it { should have_content(user.galleries.count) }
    end

    describe "delete links" do
      # normal logins shouldnt see delete link
      it { should_not have_link('Destroy') }

      describe "as an admin user" do
        # login as admin
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit users_path
        end

        it { should have_link('Destroy') }
        
        it "should be able to delete a gallery" do
          expect do
            click_link('Destroy', match: :first)
          end.to change(Gallery, :count).by(-1)
        end
       end
    end

	end

  # list users 
  describe "index" do
    let(:user) { FactoryGirl.create(:user) }
    before(:each) do
      sign_in user
      visit users_path
    end

    it { should have_title('Listing') }
    it { should have_content('Listing') }

    describe "pagination" do

      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all)  { User.delete_all }

      it { should have_selector('div.pagination') }

      it "should list each user" do

     expect(User.count).to eq(31) 
        User.paginate(page: 1).each do |user|
          expect(page).to have_selector('li', text: user.name)
        end
      end
    end

    describe "delete links" do
      # normal logins shouldnt see delete link
      it { should_not have_link('Destroy') }

      describe "as an admin user" do
        before { click_link "Sign out" }

        # login as admin
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit users_path
        end

        it { should have_link('Destroy') }
        it "should be able to delete another user" do
          expect do
            click_link('Destroy', match: :first)
          end.to change(User, :count).by(-1)
        end
        # it should not have a link to delete self
        it { should_not have_link('Destroy', href: user_path(admin)) }
      end
    end

    
    describe "with a logged out user" do
       before { click_link "Sign out" }
      before { visit users_path }
      it { should have_selector('div', text: 'Sign in') }
    end

  end

# edit a user 
  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    let(:avatar_link) { "http://gravatar.com/emails".to_s }
    before do
      sign_in user
      visit edit_user_path(user)
    end

      describe "page" do
        it{should have_content('Update your profile')}
        it{should have_title('Update your profile')}
        it{should have_link('change', href: avatar_link) }
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

      describe "forbidden attributes" do
      let(:params) do
        { user: { admin: true, password: user.password,
                  password_confirmation: user.password } }
      end
      before do
        sign_in user, no_capybara: true
        patch user_path(user), params
      end
      specify { expect(user.reload).not_to be_admin }
    end

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
        fill_in "Confirm Password", with: "foobar"
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
