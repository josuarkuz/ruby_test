module Mutations
  class DeleteTask < BaseMutation
    argument :id, ID, required: true

    type Boolean

    def resolve(id:)
      task = Task.find(id)
      task.destroy
      true
    rescue ActiveRecord::RecordNotFound
      false
    end
  end
end
