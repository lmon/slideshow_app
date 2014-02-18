require 'spec_helper'

describe "Static pages" do

  describe "Home page" do

    it "should have the content 'Slideshow App'" do
      visit '/static_pages/home'
      expect(page).to have_content('My Slideshow App')
    end

	it "should have the right title 'Slideshow App | Home'" do
	  visit '/static_pages/home'
	  expect(page).to have_title("Slideshow App | Home")
	end

  end

  describe "Help page" do
    it "should have the content 'Help Page'" do
      visit '/static_pages/help'
      expect(page).to have_content('Help Page')
    end
    
     it "should have the title 'Slideshow App | Help'" do
      visit '/static_pages/help'
      expect(page).to have_title("Slideshow App | Help")
    end
  end

  describe "About page" do
    it "should have the content 'About Page'" do
      visit '/static_pages/about'
      # page specific content
      #expect(page).to have_content('About Page')
      # tag-specific content
      expect(page).should have_selector("h1") do |content|
    	expect(content).to have_content("About Page Me!") 
  	  end
    end        
  	it "should have the right title 'Slideshow App | About'" do
	  visit '/static_pages/about'
	  expect(page).to have_title("Slideshow App | About")
	end
   end
   describe "Contact page" do
    it "should have the content 'Contact Page'" do
      visit '/static_pages/contact'
      expect(page).to have_content('Contact Page')
    end

     it "should have the title 'Slideshow App | Contact'" do
      visit '/static_pages/contact'
      expect(page).to have_title("Slideshow App | Contact")
    end

    it "should have the content 'Simple static useless'" do
      visit '/static_pages/contact'
      expect(page).to have_content('Simple static useless')
    end
    
  end
  
end