class CollaborationsController < ApplicationController

  def collaboration
    @collaboration = Wad.find(params[:id]).collaboration
    if current_user == @collaboration.wad.user
      @collaboration_requests = CollaborationRequest.where(collaboration_id: @collaboration.id)
      @tasks = Task.where(collaboration_id: @collaboration.id)
    else
      redirect_back(fallback_location: wads_path)
    end
  end

  def addCollaborator
    
  end

end
