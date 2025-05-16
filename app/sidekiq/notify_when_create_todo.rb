class NotifyWhenCreateTodo
  include Sidekiq::Job

  def perform(id)
    Rails.logger.info "Notify when todo #{id} created"
  end
end
