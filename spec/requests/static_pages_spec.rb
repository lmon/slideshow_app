require 'spec_helper'

describe "Static pages" do

let(:base_title) { 'Slideshow App | ' }

 subject { page }
  describe "Home page" do
    before { visit root_path }
    it { should have_content('App Home') }
    it { should have_title("#{base_title} Home") }
    it { should have_content('My Slideshow App') }
  end

  describe "Help page" do
    before { visit help_path }
    it { should have_content('Help Page') }
    
     it { should have_title("#{base_title} Help") }
  end

  describe "About page" do
    before { visit about_path }
    it "should have the content 'About Page'" do
      # page specific content
      #expect(page).to have_content('About Page')
      # tag-specific content
      expect(page).should have_selector("h1") do |content|
    	expect(content).to have_content("About Page Me!") 
  	  end
    end        
  	it { should have_title("#{base_title}About") }
	
   end
   describe "Contact page" do
      before { visit contact_path }
      it { should have_content('Contact Page') }
      it { should have_title("#{base_title} Contact") }
      it { should have_content('Simple static useless') }
  end

  describe "Unnamed page" do
    before { visit noname_path }
    it { should have_title("Slideshow App") }    
  end
  
end