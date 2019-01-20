class CollaborationRequestsController < ApplicationController

  def create
    @collab_request = CollaborationRequest.create(applicant_id: current_user.id, collaboration_id: params[:collaboration_request][:collaboration_id], body: params[:collaboration_request][:body])
    @collab_request.save
    redirect_to wads_path
  end

  def index
    
  end

end
