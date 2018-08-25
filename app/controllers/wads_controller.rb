class WadsController < ApplicationController
	layout 'wad', only: [:index, :popwads, :b2b, :consumertech, :media, :social, :product, :innovate, :events, :local]
	before_action :find_wad, only: [:show, :edit, :update, :destroy, :upvote]
	before_action :set_new_wad, only: [:consumertech, :b2b, :media, :innovate, :local, :social, :events, :product]
	before_action :all_wads


	def index
	 	@wads = Wad.all.order('created_at DESC')
	 	@wad = Wad.new
	 	
    end

    def popwads
		@wads = Wad.all.paginate(page: params[:page], per_page: 20)
		@rankedwads = Wad.order(cached_votes_total: :desc)
		@wad = Wad.new
	end

	def show
		redirect_to wad_comments_path(@wad)
	end

	def new
		@wad = Wad.new
	end

	def create
		@wad = current_user.wads.build(wad_params)
		if @wad.save
    		current_user.update_attributes(points: current_user.points + 50)
   			 redirect_to @wad    
		else
			flash[:error] = 'Error try again'
			render 'new'
		end
	end


	def edit
	end

	def update
			if @wad.update
				redirect_to @wad
			else
				flash[]
				render 'edit'
			end
	end

	def destroy	
			if current_user == @wad.user
				@wad.destroy
				current_user.update_attributes(points: current_user.points - 50)
				redirect_to wads_path
			else
				flash[:error] = "YOU CANNOT DELETE OTHERS' WADS"
			end
	end


	def upvote 
		@wad = Wad.find(params[:id])
		@wad.upvote_by current_user
		current_user.update_attributes(points: current_user.points + 5)  
		@wad.user.update_attributes(points: @wad.user.points + 10)
		unless current_user.voted_for? @wad  
			Notification.create(recipient: @wad.user, actor: current_user, action: "liked", notifiable: @wad)
		end	

		if @wad.get_upvotes.size % 5 == 0
				@wad.user.update_attributes(points: @wad.user.points + 50)

		end
	end

	def downvote 
		@wad = Wad.find(params[:id])
		@wad.downvote_by current_user
		current_user.update_attributes(points: current_user.points - 5)  
		@wad.user.update_attributes(points: @wad.user.points - 10)
	end		

	def join
		if Collaboration.find_by(wad_id: params[:id], user_id: current_user.id)
			flash[:notice] = "You've already joined this project!"
		else
			@collaboration = current_user.collaborations.build(wad_id: params[:id], user_id: params[:user_id]).save
		end
		redirect_to wad_comments_path(Wad.find(params[:id]))
	end

	def flag
		unless current_user.flags.find_by(wad_id: params[:id])
			flag = current_user.flags.build(wad_id: params[:id])
			flag.save
			AdminMailer.flag_notice(wad_path(Wad.find(params[:id]))).deliver_now
		end
	end

	def unflag
		if Flag.find_by(wad_id: params[:id])
			current_user.flags.find(Flag.find_by(wad_id: params[:id]).id).destroy
		end 
	end

#category views
	def consumertech
		@wads = Wad.where("category like ?", "%Consumer Tech%").paginate(page: params[:page], per_page: 20)
	end

	def b2b
		@wads = Wad.where("category like ?", "%B2B Tech%").paginate(page: params[:page], per_page: 20)
	end

	def media
		@wads = Wad.where("category like ?", "%Media and Entertainment%").paginate(page: params[:page], per_page: 20)
	end

	def social
		@wads = Wad.where("category like ?", "%Social Entrepreneurship%").paginate(page: params[:page], per_page: 20)
	end

	def local
		@wads = Wad.where("category like ?", "%Location Specific%").paginate(page: params[:page], per_page: 20)
	end

	def product
		@wads = Wad.where("category like ?", "%Consumer Products%").paginate(page: params[:page], per_page: 20)
	end


	def innovate
		@wads = Wad.where("category like ?", "%Avant-garde%").paginate(page: params[:page], per_page: 20)
	end

	def events
		@wads = Wad.where("category like ?", "%Events%").paginate(page: params[:page], per_page: 20)
	end

private

	def wad_params
		params.require(:wad).permit(:problem_state, :long_form, :category, :image, :tags)
	end

	def set_new_wad
		@wad = Wad.new
	end

	def all_wads
		@all_wads = Wad.all
	end

end
