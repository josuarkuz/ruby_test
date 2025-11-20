module Mutations
  class CreateTask < BaseMutation
    argument :project_id, ID, required: true
    argument :title, String, required: true
    argument :description, String, required: false
    argument :status, String, required: false
    argument :assignee_id, ID, required: false

    field :task, Types::TaskType, null: false

    def resolve(project_id:, title:, description: nil, status: nil, assignee_id: nil)
      project  = Project.find(project_id)
      assignee = User.find_by(id: assignee_id) if assignee_id

      task = Task.create!(
        project:,
        title:,
        description:,
        status: status || "pending",
        assignee:
      )

      { task: task }
    end
  end
end
