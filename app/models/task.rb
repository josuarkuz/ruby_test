class Task < ApplicationRecord
  belongs_to :project
  belongs_to :assignee, polymorphic: true, optional: true
  
  STATUSES = %w[pending in_progress completed].freeze
    
  validates :title, :status, presence: true
  validates :status, inclusion: { in: STATUSES }
    
  # scopes
  scope :completed, -> { where(status: "completed") }
  scope :recent,    -> { order(created_at: :desc) }
  scope :assigned_to, ->(user) { where(assignee: user) }
end
