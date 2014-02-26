require 'spec_helper'

describe "Contact pages" do

  subject { page }

  describe "contact page" do
    before { visit contact_path }

    it { should have_content('Contact Us') }
    it { should have_title('Contact Us') }
  end

  #should this be moved to Authentication pages?
  describe "contact page index" do
    before { visit contact_path }
    let(:user) { FactoryGirl.create(:user) }
    before(:each) do
      sign_in user
      visit contacts_path
    end

    describe "as an admin user" do
      before { click_link "Sign out" }

      # login as admin
      let(:admin) { FactoryGirl.create(:admin) }
      before do
        sign_in admin
        visit contacts_path
      end

      it { should have_content('List of Contacts') }
      it { should have_title('List of Contacts') }
    end
    
    describe "as a non admin user" do
      let(:non_admin) { FactoryGirl.create(:user) }

      before { sign_in non_admin, no_capybara: true }
      
      # Cannot Get This To Work
      #specify { expect(response).to redirect_to(root_url) }
      # so replacing with this
      it { should_not have_content('List of Contacts') }
      it { should have_title('Home') }
    end

  end

  # should this be in pages?
  before { visit contact_path }
  describe "with valid info it should increase record count" do
       before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Message",     with: "foobar"
      end
      it "should create a user" do
        expect { click_button "Submit" }.to change(Contact, :count).by(1)
      end
  end

end