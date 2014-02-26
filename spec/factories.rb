FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "jimmy98"
    password_confirmation "jimmy98"
  
  		factory :admin do
    	  admin true
    	end
	end
	factory :gallery do
    	title "GalleryName Lorem ipsum"
    	user
  	end
 
end