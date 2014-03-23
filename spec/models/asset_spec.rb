require 'spec_helper'

describe Asset do
   let(:upload) { File.new( imagepath) }
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
    before {asset.image = File.new(imagepath_spaces) }    
      it { should be_valid }
  end

  describe "with image of invalid type" do
    before {asset.image = File.new(imagepath_invalid_type) }    
      it { should be_invalid }
  end

  describe "with image of invalid type spoof" do
    #http://stackoverflow.com/questions/10722875/file-upload-rspec-integration-negative-test-fails ?
    before {asset.image = File.new(imagepath_spoof) }    
      it { should be_invalid }
  end

 describe "with image is too big" do
    before {asset.image = File.new(imagepath_too_big) }    
      it { should be_invalid }
  end


end
