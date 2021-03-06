
####
Portions of this app were created as part of 
# Ruby on Rails Tutorial: sample application
This is the sample application for
the [*Ruby on Rails Tutorial*](http://railstutorial.org/)
by [Michael Hartl](http://michaelhartl.com/).
####

Heroku URL: http://murmuring-ridge-6792.herokuapp.com

Slideshow App
Requirements
Tier 1
As a user 
[X]	I want to be able to login
[X]	I want to be able to logout
[X]	I want to be able to register
[X]	I want to be able to upload images
[X] I want to be able edit image metadata w/o re-uploading
[X]	I want to be able to create a gallery
[X]	I want to be able to put images in a gallery
[X]	I want to be able to order images in a gallery
[X]	I want to be able to view the gallery
[?]	I want to be able to share the gallery via a link
	I want to be able to share the gallery via code snippet

Tier 2
As the system
[X]	I want to ensure each user is unique in the site
[X]	I want uploaded images to be resized
[X]	I want uploaded images to be validated
[X]	I want uploaded images to be private
[X] I want Dev to upload to dev
[X] I want to be able to upload images with UPPERCASE in name or suffix
[X] I want to be able to upload images with a space in name

As a user
[X]	I want to be able to navigate the gallery
[X]	I want to be able to delete images
[X]	I want to be able to delete a gallery
[X]	I want to be able to make the gallery private
[X]	I want to be able to add image captions, 
[X]	I want to be able to add a gallery title
[X]	I want to be able to edit my profile w/o re-editing pw
[ ]	I want to be able to recover my password

Tier 3
As the system	
[ ]	I want to limit use of the site per hour/per user
[X]	I want to limit the number of images 
[ ]	I want to limit the server space 
[X]	I want to limit the number of galleries
[X]	I want to use HTTPS for login/logout/register
[.]	I want the site to be responsive / mobile ready 

As the User	
[X] I want to be able to email the admin via contact
[.] I want a animation on upload
[ ] I want preview on upload

Components
[X]	Register  -- User Model
[X]	Authentication  -- Authentication Controller
[X]	Gallery Display on page -- 'rambling-slider'
[.]	Gallery Display via JS
[X]	Image uploader			-- Paperclip
[X]	Image Order				-- Jquery Draggable
[X]	Emailer
[X] Amazon image storage

Issues to be addressed 
[X] Gallery edit: On load sometimes the sorting functionality doesnt work(jquery)
[X] Gallery view: On load of page, some times images dont load (jquery)
[ ] Gallery edit: Gallery/Ajax Sort call doesnt require AUTH_TOKEN 
[ ] Gallery edit: Sorting algorithim of Gallery assets is not scalable
[ ] Gallery View: Formatting doesnt handle different size images well

Refactoring Needed
[ ] Nested Resources (update form,controller, links)
[ ] Nested Models
[. ] Ajaxify links (User delete, Gallery delete)
[ ] On [ACTION] handlers (before_save/after_update, etc)
[ ] Optimize Queries 
[ ] Add "includes"
[ ] Make Routes more restful
[ ] Use Path & URL helpers
