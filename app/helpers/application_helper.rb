module ApplicationHelper
REGEX_PATTERN = /^(.+)@(.+)$/
def name
	if Church.all.count > 0
		Church.first.name 
	else
		"Not Configured"
	end
end

def is_email_valid? email
    email =~REGEX_PATTERN
end
end
