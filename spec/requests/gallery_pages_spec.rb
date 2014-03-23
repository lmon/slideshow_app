require 'spec_helper'

describe "Gallery Pages" do
  subject { page }

  let(:user) { FactoryGirl.create(:user, name: "lucas") }
  let(:otheruser) { FactoryGirl.create(:user) }
  after(:all)  { User.delete_all }
  
  before { sign_in user }

  describe "gallery creation" do
    before { visit new_gallery_path }

    describe "with invalid information" do
      it "does not create a gallery" do
        expect { click_button "Create" }.not_to change(Gallery, :count)
      end

      it "has error messages" do
        click_button "Create" 
        expect(page).to have_content('error') 
      end
    end

    describe "with valid information" do
      before { fill_in 'gallery_title', with: "Lorem ipsum Title" }
      
      it "should create a gallery" do
        expect { click_button "Create" }.to change(Gallery, :count).by(1)
        expect(page).to have_selector('h1', text: "Lorem ipsum Title")
      end
      
      it "should put me on the new gallery's page" do
        expect(page).to have_selector('h1', "Lorem ipsum Title")       
      end

      describe "testing maximum" do
        #create the limit
        before { 30.times { FactoryGirl.create(:gallery, user: user)  } } 
        after { Gallery.delete_all }

        it "should allow 30 galleries" do
          expect(Gallery.count).to eq(30) 
        end

        # add one over max
        it "should prevent me from creating more than 30 galleries" do
          expect { FactoryGirl.create(:gallery, user: user) }.to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Cannot add any more Galleries') # OR raise_exception 
        end
      end
    end
  end

 describe "index" do
	# all people, no editing
  	describe "pagination" do
      before { 15.times { FactoryGirl.create(:gallery, user: user)  } } 
      after { Gallery.delete_all }

      before { visit galleries_path } # goes to index

      it "has listing copy" do
          expect(page).to have_content('Listing') 
      end  

      it "should list each gallery" do
        expect(Gallery.count).to eq(15) 
          Gallery.paginate(page: 1).each do |gallery|
             expect(page).to have_selector('li', text: gallery.title)
             expect(user).to eq gallery.user
           end
      end
  end

    describe "click view link" do            
      before { 
          @gallery = FactoryGirl.create(:gallery, user: user, title: "Foo")
          visit gallery_path(@gallery)  
        }

        it "has listing copy" do
            expect(page).to have_content(@gallery.title) 
        end   

        it "should show gallery" do   	
          expect(page).to have_content('Gallery Viewer') 
        end
    
      describe "with user who is owner" do
       it "should have Upload images link" do
        expect(page).to have_content('Upload images') 
        end
      end
  
      describe "with user who is not owner" do
        before { 
          click_link "Sign out"
          sign_in otheruser, no_capybara: true 
          visit gallery_path(@gallery)  
        }

        it "should not have Upload images link" do
          expect(page).to_not have_content('Edit') 
          expect(page).to have_content('Gallery Viewer') 
          expect(page).to have_content(@gallery.title) 
        end
      end
    end

  describe "with user who is not owner" do
    before { visit gallery_path(:id => 1000 ) }
  	it "shows a nice not found page" do
      expect(page).to have_content('Record Not Found') 
    end

 	  it "should not show editing functions" do
       expect(page).to_not have_content('Edit') 
    end
  end

end

 	describe "when updating" do
       
      before { 
        @gallery = FactoryGirl.create(:gallery, user: user, title: "My Testing Gallery Title") 
        visit edit_gallery_path(@gallery) 
      } 
 
      it "with content 'Update your gallery'" do 
        expect(page).to have_content("Update your gallery") 
        expect(page).to have_content(@gallery.title) 
      end


      describe "with a new title" do
        let(:new_title)  { "An updated Title" }
        # change form data
        before { 
          fill_in 'gallery_title', with: new_title 
          click_button "Update Gallery"
        }
        # change form data
        it "has updated title" do
            expect(@gallery.reload.title).to  eq new_title  
        end
      end
    end

  describe "when managing images" do

     it "has the right images in the asset_order with new gallery" do
       pending
     end

     it "has correct order in the asset_order when image added" do
       pending
     end

     it "has correct order in the asset_order when image removed" do
       pending
     end

     it "has correct order in the asset_order when images reordered" do
       pending
     end
     
     it "has empty asset_order after all images removed" do
       pending
     end
  
  end
    
  describe "when deleting" do
  	  # create a gallery
      before { 
        @gallery = FactoryGirl.create(:gallery, user: user, title: "My Gallery To Del") 
        visit user_path(user) 
     } 

     it "has the right page" do
      expect(page).to have_content("My Galleries") 
     end

     it "has the gallery title in list" do
      expect(page).to have_content(@gallery.title) 
     end
 
     it "should remove this gallery" do
  		  expect{ click_link('Destroy', match: :first) }.to change(Gallery, :count).by(-1)      	 
        expect(page).to_not have_content(@gallery.title) 
     end

  end

describe "gallery show" do
  describe "should show all the images included in that gallery" do
      before { 
    # create a gallery
        @gallery = FactoryGirl.create(:gallery, user: user, title: "My Gallery To Del") 
        visit gallery_path(@gallery)
     } 
   # upload 2 assets
=begin   
    
   let(:upload) { File.new( imagepath) }
   let(:asset1) { FactoryGirl.create(:asset, name: "test title1", caption: "my test caption1", image: upload, user: user ) }
   let(:asset2) { FactoryGirl.create(:asset, name: "test title2", caption: "my test caption2", image: upload, user: user ) }

   describe "it has the correct count" do
   # attach asset to gallery
   before { @image = @gallery.assets.build(:name=>"test title3", :caption=> "my test caption3", :image=> upload, user: user ) }
=end   
     it "should have Assets area" do
      #@gallery.assets.include?(asset) 
      expect(page).to have_content("Has Assets: Count: 1") 
    end
  #end

    # view gallery

     it "should have sliderArea area" do
    # test for presence of those assets
      expect(page).to have_selector('span', 'xxx')    
    end


  end
end


end
