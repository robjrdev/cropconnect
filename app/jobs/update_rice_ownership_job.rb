class UpdateRiceOwnershipJob < ApplicationJob
    queue_as :default
  
    def perform(rice_id)
      rice = Rice.find(rice_id)
      rice.check_and_update_ownership
    end
  end
  