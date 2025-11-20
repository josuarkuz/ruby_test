class TaskStatusUpdater
  def initialize(task:, new_status:, actor:)
    @task = task
    @new_status = new_status
    @actor = actor
  end

  def call
    return false unless Task::STATUSES.include?(@new_status)

    Task.transaction do
      @task.update!(status: @new_status)

      ActivityLoggerJob.perform_later(
        record_type: "Task",
        record_id: @task.id,
        action: "status_changed_to_#{@new_status}",
        actor_id: @actor.id
      )
    end

    true
  rescue StandardError => e
    Rails.logger.error("[TaskStatusUpdater] #{e.class}: #{e.message}")
    false
  end
end
