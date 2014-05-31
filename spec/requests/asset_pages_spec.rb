require 'spec_helper'

describe "Asset Pages" do

  subject { page }

   let(:owneruser) { FactoryGirl.create(:user, name: "lucas!") }
   let(:nonowneruser) { FactoryGirl.create(:user, name: "janine!") }
   let(:upload) { File.new( imagepath)  }
   let(:ownedasset){ FactoryGirl.create(:asset, image: upload, user: owneruser)  } 

  
  describe "Index" do
    #before { visit assets_path } # goes to index
    before(:each) do
      sign_in owneruser
      visit assets_path # goes to index
    end

    context "with owner user" do

      context "with no items" do
        
        it "should show empty list and add button" do
          expect(page).to have_content('Listing assets')
        end
      end
      context "with <10 items" do
        # create 9 items
        before { 
            9.times { FactoryGirl.create(:asset, image: upload, user: owneruser)  } 
            visit assets_path
        } 
        after { Asset.delete_all }
        it "should have the right amount of assets" do
          expect(Asset.count).to eq(9) 
        end

        it "should show list"  do
          expect(page).to have_content('Listing assets (9)')
        end        
      end

      context "with >10 items" do
        before { 
            15.times { FactoryGirl.create(:asset, image: upload, user: owneruser)  } 
            visit assets_path
        } 
        after { Asset.delete_all }

        it "should show paginated list"  do
          expect(page).to have_selector('div.pagination') 
        end
      end
    end  
    
    
  end  

  describe "Create" do
    context "with logged in user" do
      before { 
        sign_in owneruser 
        visit new_asset_path
      }  

      it "should have create form" do
        expect(page).to have_content('New asset') 
      end

      context "with valid data" do
        
        before { 
          fill_in 'asset_name', with: "Lorem ipsum Title"
          attach_file 'asset_image', imagepath    
        }
        it "should create an asset" do
          expect { click_button "Create Asset" }.to change(Asset, :count).by(1)
        end

        it "should send me to asset page" do
          expect { click_button "Create Asset" }.to change(Asset, :count).by(1)
          expect(page).to have_selector('div.field', text: 'Lorem ipsum Title') 
          expect(page).to have_xpath("//img[contains(@src, 'ninam.png')]")   
        end

        context "is over quota" do
            before { 51.times{  
              fill_in 'asset_name', with: "Lorem ipsum Title"
              attach_file 'asset_image', imagepath    
                click_button "Create Asset"
                visit new_asset_path
              }
            }
          it "should not create an asset" do
            expect(Asset.count).to eq(50)
          end
        end
      end
      
      context "with invalid data" do
        before { 
          #fill_in 'asset_name', with: "Lorem ipsum Title"
          attach_file 'asset_image', imagepath    
        }

        it "should not create an asset" do
          expect { click_button "Create Asset" }.to change(Asset, :count).by(0)
        end

        before { click_button "Create Asset" }
        it "should send me back to create form" do
          expect(page).to have_content("New asset") 
        end

        before { click_button "Create Asset" }
        it "should display an error" do
          expect(page).to have_selector('div#error_explanation') 
          expect(page).to have_content("Name can't be blank") 
        end
      end
    end

    context "with logged out user" do
      let(:assetcount){Asset.count}
      before {  
        visit new_asset_path
      }  
      
      it "should not show me the create button" do
        expect(page).not_to have_selector('input', text: 'Create Asset') 
      end

      it "should send me to the sign in page" do
        expect(page).to have_content('Sign up now') 
      end
 
      it "should not create an asset" do
        expect(Asset.count).to eq(assetcount)
      end
    end
  end  

  describe "Show" do 

    context "with logged in user" do
      
      context "as owner" do
        before { 
          sign_in owneruser 
          visit asset_path(ownedasset)
        }  

        it "should show me the asset details" do
          expect(page).to have_content('Name: ' + ownedasset.name) 
          expect(page).to have_content('Caption: '+ ownedasset.caption) 
          expect(page).to have_xpath("//img[contains(@src, 'ninam.png')]")   
        end

        it "should show me the destroy & edit buttons" do
          expect(page).to have_content('Destroy') 
          expect(page).to have_content('Edit') 
        end  
      end

      context "as nonowner" do
        before { 
          sign_in nonowneruser 
          visit asset_path(ownedasset)
        }  
      
        it "should show me the asset details" do
          expect(page).to have_content('Name: ' + ownedasset.name) 
          expect(page).to have_content('Caption: '+ ownedasset.caption) 
          expect(page).to have_xpath("//img[contains(@src, 'ninam.png')]")   
        end

        it "should show me the destroy & edit buttons" do
          expect(page).not_to have_content('Destroy') 
          expect(page).not_to have_content('Edit') 
        end        
      end


    end

    context "with logged out user" do
      # make sure we sign out
      before {   
      visit asset_path(ownedasset)
      }
       it "should show me the asset details" do
          expect(page).to have_content('Name: ' + ownedasset.name) 
          expect(page).to have_content('Caption: '+ ownedasset.caption) 
          expect(page).to have_xpath("//img[contains(@src, 'ninam.png')]")   
        end

        it "should show me the destroy & edit buttons" do
          expect(page).not_to have_content('Destroy') 
          expect(page).not_to have_content('Edit') 
        end      

    end

  end  

  describe "Delete" do
    
    context "with owner user" do
      before { 
        sign_in owneruser 
        visit asset_path(ownedasset)
      }

      it "should remove from the database" do
        expect{ click_link('Destroy', match: :first) }.to change(Asset, :count).by(-1)         
        expect(page).to_not have_content(ownedasset.name) 
        expect(page).to have_content('Listing assets') 
        
      end
    end  
    
    context "with non-owner user" do
      before { 
        sign_in nonowneruser 
        visit asset_path(ownedasset)
      }

      describe "submitting to the destroy action" do
          before { delete asset_path(ownedasset) }
          specify { expect(response).to redirect_to(signin_path) }
      end
    end  

    context "with logged out user" do
      before { 
        visit asset_path(ownedasset)
      }
       
      it "should have sign in link" do
        expect(page).to have_content('Sign in') 
      end

      describe "submitting to the destroy action" do
          before { delete asset_path(ownedasset) }
          specify { expect(response).to redirect_to(signin_path) }
      end

    end  
  end  

  describe "Update" do
    context "with owner user" do
      before { 
        sign_in owneruser
        visit asset_path(ownedasset) 
      }
      
      it "should show the edit button" do
        expect(page).to have_content('Edit') 
      end

      before {  
          visit edit_asset_path(ownedasset) 
          fill_in 'asset_name', with: "New Title"
          click_button "Update Asset"
        }

        it { should have_content("Name: New Title") }
        #[TODO]
        #it { should have_selector('div.alert.alert-success') } 
        specify { expect(ownedasset.reload.name).to  eq "New Title" } 
    end  
    
    context "with non-owner user" do
      before {  
        sign_in nonowneruser 
        visit asset_path(ownedasset)
      }
      
      it "should not show the edit button" do
        expect(page).not_to have_content('Edit') 
      end

      describe "submitting to the update action" do
          before { patch asset_path(ownedasset) }
          specify { expect(response).to redirect_to(signin_path) }
      end

    end  

    context "with logged out user" do
       before {  
        visit asset_path(ownedasset)
      }
      
      it "should have sign in link" do
        expect(page).to have_content('Sign in') 
      end

      it "should not show the edit button" do
        expect(page).not_to have_content('Edit') 
      end

      describe "submitting to the update action" do
          before { patch asset_path(ownedasset) }
          specify { expect(response).to redirect_to(signin_path) }
      end


    end  
  end  

end
