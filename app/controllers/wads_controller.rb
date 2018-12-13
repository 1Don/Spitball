class WadsController < ApplicationController
	layout 'wad', only: [:index, :popwads, :tech, :b2b, :media, :innovate, :gadgets, :lifestyle, :social]
	before_action :find_wad, only: [:show, :edit, :update, :destroy, :upvote]
	before_action :set_new_wad, only: [:tech, :b2b, :media, :innovate, :gadgets, :lifestyle, :social, :popwads]
	before_action :all_wads
	before_action :require_login

	def index
	 	@wads = Wad.all.order('created_at DESC')
	 	@wad = Wad.new
		@session_created_at = session[:created_at].to_i
		@time_now = Time.now.to_i
  end

  def popwads
		@wads = Wad.order(cached_votes_up: :desc)
	end

	def show
		redirect_to wad_comments_path(@wad)
	end

	def new
		redirect_to wads_path
		@wad = Wad.new
	end

	def create
		@wad = current_user.wads.build(wad_params)
		if @wad.save
    		current_user.update_attributes(points: current_user.points + 50)
   			 redirect_to @wad
		else
			flash[:error] = @wad.errors.full_messages
			redirect_back(fallback_location: wads_path)
		end
	end

	def add_link
		@wad = Wad.find(params[:id])
		if current_user = @wad.user
			@wad.link = params[:link]
			@wad.save
		end
		redirect_back(fallback_location: wads_path)
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
				@wad.image.purge
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
	def tech
		@wads = Wad.where("category like ?", "%Technology and Apps%").paginate(page: params[:page], per_page: 20)
	end

	def b2b
		@wads = Wad.where("category like ?", "%Finance and B2B%").paginate(page: params[:page], per_page: 20)
	end

	def media
		@wads = Wad.where("category like ?", "%Media and Entertainment%").paginate(page: params[:page], per_page: 20)
	end

	def gadgets
		@wads = Wad.where("category like ?", "%Hardware and Gadgets%").paginate(page: params[:page], per_page: 20)
	end

	def social
		@wads = Wad.where("category like ?", "%Non-profit and Social Entrepreneurship%").paginate(page: params[:page], per_page: 20)
	end

	def lifestyle
		@wads = Wad.where("category like ?", "%Events and Lifestyle%").paginate(page: params[:page], per_page: 20)
	end


	def innovate
		@wads = Wad.where("category like ?", "%Avant-garde%").paginate(page: params[:page], per_page: 20)
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
