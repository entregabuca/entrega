module ApplicationHelper

	def log_error(msg, trace)
		puts "\tERROR:: #{msg.class}: #{msg.message} \n\t\t#{trace.first}"

		"App Error: Please contact the Administrator."
	end

	def address(variable, i)
		if variable.locations[i].present?
			variable.locations[i].address
		else
			"-"
		end
	end

	def coordinates(variable, i)
		if variable.present? && variable.locations[i].present?
			[variable.locations[i].latitude, variable.locations[i].longitude]
		else
			#raise "ERROR: No coordinates found."
      [0, 0]
		end
	end

	def coordinates?(variable, i)
		if variable.present? && variable.locations[i].present?
			true
		else
			false
		end
	end

	def mean_coordinates(variable, i)
		clean_var = variable.select{|c| c.locations[i]}
		if clean_var.size > 1
			[clean_var.map{|c| c.locations[i].latitude}.sum / clean_var.size, 
			 clean_var.map{|c| c.locations[i].longitude}.sum / clean_var.size]
		else
			[0,0]
		end
	end

	# Adds active status on navbar-links 
	def link_to_in_li(body, url, html_options = {})
	  active = "active" if current_page?(url)
	  content_tag :li, class: active do
	  link_to body, url, html_options
	  end
	end


end
