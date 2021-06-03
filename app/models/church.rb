class Church < ApplicationRecord
	mount_uploader :avatar, AvatarUploader

	def custom_tithing
		if self.giving_override != nil && self.giving_override != ""
			return true
		else
			return false
		end
	end
	def doTwitter(handle)
		return handle.sub("@","https://www.twitter.com/")
	end
	def doInstagram(handle)
		return handle.sub("@","https://www.instagram.com/")
	end
	def doYouTube(handle)
		return handle.sub("@","https://www.youtube.com/")
	end
	def social_links
		spots = 0
		if self.fb?
			spots+= 1
		end
		if self.instagram?
			spots+= 1
		end
		if self.twitter?
			spots+= 1
		end
		if self.yt?
			spots += 1
		end
		response = "<div class='grid grid-cols-#{spots} gap-2 place-items-center mt-2'>"
		if self.fb
			# Facebook
			response += "<div><a href='#{self.fb}'><img src='https://img.icons8.com/color/50/000000/facebook.png'/></a></div>"
		end
		if self.yt
			# YouTube
			response += "<div><a href='#{self.yt}'><img src='https://img.icons8.com/color/48/000000/youtube-play.png'/></a></div>"
		end
		if self.instagram
			# InstaFace
			response += "<div><a href='#{doInstagram(self.instagram)}'><img src='https://img.icons8.com/color/48/000000/instagram-new--v1.png'/></a></div>"
		end
		if self.twitter
			#twitter
			response += "<div><a href='#{doTwitter(self.twitter)}'><img src='https://img.icons8.com/color/48/000000/twitter--v1.png'/></a></div>"
		end
		response += "</div>"
		return response
	end
end
