module Types
  class TaskType < Types::BaseObject
    implements Types::TimestampedType

    field :id, ID, null: false
    field :title, String, null: false
    field :description, String, null: true
    field :status, String, null: false
    field :project, Types::ProjectType, null: false
    field :assignee, Types::UserType, null: true
    
    field :project_id,  ID, null: false
    field :assignee_id, ID, null: true
  end
end
