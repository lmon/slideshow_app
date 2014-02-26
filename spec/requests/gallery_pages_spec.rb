require 'spec_helper'

describe "Gallery Pages" do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "gallery creation" do
    before { visit new_gallery_path }

    describe "with invalid information" do

      it "should not create a gallery" do
        expect { click_button "Create" }.not_to change(Gallery, :count)
      end

      describe "error messages" do
        before { click_button "Create" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do

      before { fill_in 'gallery_title', with: "Lorem ipsum" }
      it "should create a gallery" do
        expect { click_button "Create" }.to change(Gallery, :count).by(1)
      end
    end
  end

end
