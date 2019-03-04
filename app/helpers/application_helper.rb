module ApplicationHelper
	def address(variable, i)
		if variable.locations[i].present?
			variable.locations[i].address
		else
			"-"
		end
	end

	def coordinates(variable, i)
		if variable.locations[i].present?
			[variable.locations[i].latitude, variable.locations[i].longitude]
		else
			[0,0]
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
end
