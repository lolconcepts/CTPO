module ApplicationHelper
def name
	if Church.all.count > 0
		Church.first.name 
	else
		"Not Configured"
	end
end
end
