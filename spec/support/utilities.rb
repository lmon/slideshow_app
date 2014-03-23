include ApplicationHelper

def sign_in(user, options={})
  if options[:no_capybara]
    # Sign in when not using Capybara.
    remember_token = User.new_remember_token
    cookies[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
  else
    visit signin_path
    fill_in "Email",    with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"
  end
end

def sign_out
  click_link "Sign out" 
end

def imagepath
  "/Library/WebServer/Documents/MonacoWork/ruby/slideshow/slideshow/lib/assets/ninam.png"
end

def imagepath_spaces
  "/Library/WebServer/Documents/MonacoWork/ruby/slideshow/slideshow/lib/assets/test ninam copy.png"
end

def imagepath_invalid_type
  "/Library/WebServer/Documents/MonacoWork/ruby/slideshow/slideshow/lib/assets/D6Flex.swf"
end

def imagepath_spoof
  "/Library/WebServer/Documents/MonacoWork/ruby/slideshow/slideshow/lib/assets/D6Flex_swf.jpg"
end

def imagepath_too_big
  "/Library/WebServer/Documents/MonacoWork/ruby/slideshow/slideshow/lib/assets/test_large4.3mb.jpg"
end