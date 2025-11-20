class ActivityLoggerJob < ApplicationJob
  queue_as :default

  def perform(record_type:, record_id:, action:, actor_id: nil)
    Activity.create!(
      record_type: record_type,
      record_id: record_id,
      action: action
    )
  end
end
