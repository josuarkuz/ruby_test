module Types
  class ProjectType < Types::BaseObject
    implements Types::TimestampedType
    
    field :id, ID, null: false
    field :name, String, null: false
    field :description, String, null: true
    field :tasks, [Types::TaskType], null: true
  end
end
