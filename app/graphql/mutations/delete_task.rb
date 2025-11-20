module Mutations
  class DeleteTask < BaseMutation
    argument :id, ID, required: true

    field :task, Types::TaskType, null: true
    field :success, Boolean, null: false

    def resolve(id:)
      task = Task.find_by(id: id)
      return { task: nil, success: false } unless task

      task.destroy
      { task: task, success: true }
    end
  end
end
