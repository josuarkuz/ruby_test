class ActivityLoggerJob < ApplicationJob
  queue_as :default

  def perform(record_type:, record_id:, action:, actor_id: nil, metadata: {})
    Activity.create!(
      record_type: record_type,
      record_id: record_id,
      action: action,
      actor_id: actor_id,
      metadata: metadata
    )
  end
end
