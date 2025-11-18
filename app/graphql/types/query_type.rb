module Types
  class QueryType < Types::BaseObject
    field :hello, String, null: false

    def hello
      "GraphQL is working"
    end

    field :projects, [ProjectType], null: false
    field :project, ProjectType, null: true do
      argument :id, ID, required: true
    end

    field :tasks, [TaskType], null: false do
      argument :status, String, required: false
    end

    field :task, TaskType, null: true do
      argument :id, ID, required: true
    end

    def projects
      Project.all
    end

    def project(id:)
      Project.find_by(id: id)
    end

    def tasks(status: nil)
      scope = Task.all
      scope = scope.where(status: status) if status.present?
      scope
    end

    def task(id:)
      Task.find_by(id: id)
    end
  end
end
