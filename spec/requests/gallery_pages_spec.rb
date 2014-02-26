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

describe "gallery access" do
	# all people, no editing
  	before { @gallery = user.galleries.build(title: "My Testing Gallery Title") }
  	
  	describe "as a regular user" do
	    before { visit galleries_path } # goes to index
  	  	it {should have_content('Listing') }
	    before{click_link(@gallery.title)} 
     
        it "should show gallery" do   	
			expect(page).to have_content('Gallery Viewer') 
        end
	end
  	describe "should show a nice not found page" do
 #     before { visit gallery_path(:id => 1000 ) }
 #       it { should have_content('Not Found') }
    end

 	describe "should not show editing functions" do
  #      it { should_not have_content('Edit') }
    end

	#logged in people, can see edit functions if proper user
 	describe "should show editing functions for own galleries" do
      pending
      #  it { should have_content('Edit') }
    end

end

describe "gallery update" do
 	describe "should update data" do
      pending
      # create a gallery
      # view gallery
      # change form data
      # it should have new content
      #  it { should have_content('Edit') }
    end
end

describe "gallery delete" do
	describe "should remove this gallery and go to the Profile" do
		# create a gallery
      	# view gallery
      	# delete the gallery
      	# revisit gallery
      	#  gallery page should say not found
	end
end


end
