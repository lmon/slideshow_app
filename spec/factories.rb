FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@aexample.com"}
    password "jimmy98"
    password_confirmation "jimmy98"
  
  		factory :admin do
    	  admin true
    	end
	end

	factory :gallery do
    sequence(:title)  { |n| "Gallery Title #{n}" }
     user

#    	title "GalleryName Lorem ipsum"
  end
 
 #######################
  factory :contact do
    name "contactingperson"
    email "person@mycontact.com"
    message "this is a test message" 
  end

 #######################
  factory :asset do
    name "mytestasset"
    caption "this is the caption that I am including in my test"
    image 1
    user 2
  end


end

