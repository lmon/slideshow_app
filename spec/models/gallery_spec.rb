require 'spec_helper'

describe Gallery do 

  let(:user) { FactoryGirl.create(:user) }
   
  before { @gallery = user.galleries.build(title: "Lorem ipsum") }

  subject { @gallery }

  it { should respond_to(:title) }
  it { should respond_to(:user_id) }

  it { should respond_to(:asset_order) }
  it { should respond_to(:private) }
  it { should respond_to(:asset_list) }
  it { should respond_to(:freindly_name) }

  it { should respond_to(:user) }
  its(:user) { should eq user }


  it { should be_valid }

  describe "when user_id is not present" do
    before { @gallery.user_id = nil }
    it { should_not be_valid }
  end
  describe "when title is not present" do
    before { @gallery.title = nil }
    it { should_not be_valid }
  end
  describe "when title is too long" do
    before { @gallery.title = "a"*129 }
    it { should_not be_valid }
  end

end
 
