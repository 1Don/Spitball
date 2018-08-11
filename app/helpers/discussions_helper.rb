module DiscussionsHelper
	def discussions_tree_for(discussions)
    	discussions.map do |discussions, nested_discussions|
	      render(discussions) +
	          (nested_discussions.size > 0 ? content_tag(:div, discussions_tree_for(nested_discussions), class: "replies") : nil)
	    end.join.html_safe
  	end


  	def discussions_bar
	  	[
	      {
	        link: "/fundraising",
	        name: "Fundraising"
	      },

	      {
	        link: "/teambuilding",
	        name: "Building A Team"
	      },

	      {
	        link: "/mentorship",
	        name: "How To Find A Mentor"
	      },

	      {
	        link: "/marketing",
	        name: "Marketing"
	      },
	      
	      {
	        link: "/entityformation",
	        name: "Legal Registraion"
	      },
	      {
	        link: "/unicorns",
	        name: "How Did That Other Company Do It"
	      },
	      {
	        link: "/random",
	        name: "Random"
	      },
	      {
	        link: "/other",
	        name: "Other"
	      }
	    ]

  	end



end
