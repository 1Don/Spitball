module WadsAndCommentsHelper
#Finds wad for Wads controller for routes without /comments/:id
	def find_wad
		@wad = Wad.find(params[:id])
	end

#Finds wads for Comments controller for routes with /comments/:id
	def find_comments_wad
		@wad = Wad.find(params[:wad_id])
	end

#Finds comment for either controller
	def find_comment
		@wad = Wad.find(params[:wad_id])
		@comment = @wad.comments.find(params[:id])
	end
#Finds the user for linking to their profile
	def find_wad_owner
		find_comments_wad
		@owner = @wad.user
	end
end