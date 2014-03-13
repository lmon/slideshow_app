require 'spec_helper'

describe Asset do
   let(:testfilespath) {Rails.root + '/Library/WebServer/Documents/MonacoWork/ruby/slideshow/slideshow/lib/assets/'}
   let(:upload) { File.new( testfilespath + 'ninam.png') }
 	 let(:user) { FactoryGirl.create(:user) }
   let(:asset) { FactoryGirl.create(:asset, name: "test title", caption: "my test caption", image: upload, user: user ) }


  subject { asset }

   it { should respond_to(:name) }
   it { should respond_to(:user_id) }

   it { should respond_to(:caption) }

   it { should respond_to(:user) }
   its(:user) { should eq user }

  it { should be_valid }

   describe "when user_id is not present" do
    before { asset.user_id = nil }
    it 'is not valid' do
      expect{  to_not be_valid }
    end
  end

  describe "when name is not present" do
    before { asset.name = nil }
    it 'is not valid' do
      expect{  to_not be_valid }
    end 
  end

  describe "when title is too long" do
    before { asset.name = "a"*65 }
    it 'is not valid' do
      expect{  to_not be_valid }
    end 
  end
  
  describe "with code in the title" do
     before { asset.name = "test<b>test"  }
      it { should be_invalid }
  end

  describe "when caption is not present" do
    before { asset.caption = nil }
    it 'is not valid' do
      expect{ to be_valid }
    end 
  end
  
  describe "when caption is too long" do
    before { asset.caption = "a"*513 }
    it 'is not valid' do
      expect{  to_not be_valid }
    end 
  end
  
  describe "with code in the caption" do
     before { asset.caption = "test<b>test"  }
      it { should be_invalid }
  end

  describe "with image name has spaces" do
    before {asset.image = File.new(testfilespath + 'test ninam copy.png') }    
      it { should be_valid }
  end

  describe "with image of invalid type" do
    before {asset.image = File.new(testfilespath + 'D6Flex.swf') }    
      it { should be_invalid }
  end

  describe "with image of invalid type spoof" do
    before {asset.image = File.new(testfilespath + 'D6Flex_swf.jpg') }    
      it { should be_invalid }
  end

 describe "with image is too big" do
    before {asset.image = File.new(testfilespath + 'test_large4.3mb.jpg') }    
      it { should be_invalid }
  end


end
