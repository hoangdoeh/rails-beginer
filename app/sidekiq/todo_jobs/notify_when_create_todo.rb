
module TodoJobs
  class NotifyWhenCreateTodo < ActiveJob::Base
    def perform(id)
      Rails.logger.info "Notify when todo #{id} created"
    end
  end
end
