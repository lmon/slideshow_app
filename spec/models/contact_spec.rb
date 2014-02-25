require 'spec_helper'

describe Contact do

	before do
	    @contact = Contact.new(name: "contactingperson", email: "person@mycontact.com", message:"this is a test message")
  	end
	
	subject{@contact}

	it { should respond_to(:name) }
  	it { should respond_to(:email) }
  	it { should respond_to(:message) }
  
  	it { should be_valid }

  
  describe "with no name" do
   	before { @contact.name = "" }
      it { should be_valid }
  end

  describe "with no email" do
     before { @contact.email = ""  }
      it { should be_invalid }
  end

  describe "with no message" do
     before { @contact.message = ""  }
      it { should be_invalid }
  end

  describe "with a name thats too long" do
     before { @contact.name = "a" * 33  }
      it { should be_invalid }
  end

  describe "with an invalid email" do
     before { @contact.email = "myinvalidemail"  }
      it { should be_invalid }
  end

  describe "with a message thats too long" do
     before { @contact.message = "m"*513  }
      it { should be_invalid }
  end


end
