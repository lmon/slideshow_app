require 'spec_helper'

describe Asset do
  
  	let(:upload) { File.new(Rails.root + '/Library/WebServer/Documents/MonacoWork/ruby/slideshow/slideshow/lib/assets/ninam.png') }
 	let(:user) { FactoryGirl.create(:user) }
 	
=begin
 	before { 
 		@asset = user.assets.build(
 			name: "mytestasset",
    		caption: "this is the caption that I am including in my test",
    		image:  upload
    	) 
 	}
=end

   let(:assettwo) { FactoryGirl.create(:asset, name: "AABB", caption: "ccc", image: upload, user: user ) }


  subject { assettwo }

   it { should respond_to(:name) }
   it { should respond_to(:user_id) }

   it { should respond_to(:caption) }

   it { should respond_to(:user) }
   its(:user) { should eq user }


  it { should be_valid }
end
