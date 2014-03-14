require 'spec_helper'

describe Gallery do 

  let(:user) { FactoryGirl.create(:user) }
   
  before { @gallery = user.galleries.build(title: "Lorem ipsum") }

  subject { @gallery }

  it { should respond_to(:title) }
  it { should respond_to(:user_id) }

  it { should respond_to(:asset_order) }
  it { should respond_to(:private) }

  it { should respond_to(:user) }
  its(:user) { should eq user }


  it { should be_valid }

  describe "when user_id is not present" do
    before { @gallery.user_id = nil }
    it 'is not valid' do
      expect{  to_not be_valid }
    end
  end

  describe "when title is not present" do
    before { @gallery.title = nil }
    it 'is not valid' do
      expect{  to_not be_valid }
    end 
  end
  describe "when title is too long" do
    before { @gallery.title = "a"*129 }
    it 'is not valid' do
      expect{  to_not be_valid }
    end 
  end

  describe "with code in the title" do
     before { @gallery.title = "test<b>test"  }
      it { should be_invalid }
  end

  describe "when is private" do
     before { @gallery.private = true  }
      it { should be_valid }
  end
  describe "when is not private" do
     before { @gallery.private = false  }
      it { should be_valid }
  end

  describe "when the user is trying to create more than 10 galleries" do
      it { should be_invalid }
  end



end
 
