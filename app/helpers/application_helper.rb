module ApplicationHelper
def name
	Church.first.name || "Not Configured"
end
end
