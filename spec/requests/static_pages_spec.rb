require 'spec_helper'

describe "Static pages" do

let(:base_title) { 'Slideshow App | ' }

 subject { page }

  shared_examples_for "all_static_pages" do
    it { should have_selector('h1', text: heading) }
    it { should have_title(page_title) }
  end

  describe "Home page" do
    before { visit root_path }
    it { should have_content('Slideshow App') }

    let(:heading)    { 'Slideshow App' }
    let(:page_title) { "#{base_title} Home" }

    it_should_behave_like "all_static_pages"

    #it { should have_title("#{base_title} Home") }
    #it { should have_content('My Slideshow App') }
  end

  describe "Help page" do
    before { visit help_path }
    let(:heading)    { 'Help' }
    let(:page_title) { "#{base_title} Help" }
    it_should_behave_like "all_static_pages"

    it { should have_content('Help Page') }
  end

  describe "About page" do
    before { visit about_path }
       # page specific content
      #expect(page).to have_content('About Page')
      # tag-specific content
      it { should have_selector("h1", text:  "About Page Me!") } 
     it { should have_title("#{base_title} About") }
	
   end
    

  describe "Unnamed page" do
    before { visit noname_path }
    it { should have_title("Slideshow App") }    
  end
  
# link click testing
 it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    expect(page).to have_title("#{base_title} About")
    click_link "Help"
    #expect(page).to # fill in
    click_link "Contact"
    #expect(page).to # fill in
    click_link "Home"
    click_link "Sign up now!"
    #expect(page).to # fill in
end


end