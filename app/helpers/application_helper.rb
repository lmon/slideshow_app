module ApplicationHelper
	# Returns the full title on a per-page basis.
  	def full_title(page_title)
		base_title = "Slideshow App"	
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}" 
		end
	end

	def debug_layout(s)
		"<div class=\"debug\"> #{s} </div>".html_safe
	end	

end
