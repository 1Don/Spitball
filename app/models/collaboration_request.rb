class CollaborationRequest < ApplicationRecord
  validates :body, presence: true, length: { maximum: 5000 }
  validates :collaboration_id, presence: true
  validates :applicant_id, presence: true
end
