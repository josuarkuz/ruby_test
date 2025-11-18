module Mutations
  class DeleteProject < BaseMutation
    argument :id, ID, required: true

    type Boolean

    def resolve(id:)
      project = Project.find(id)
      project.destroy
      true
    rescue ActiveRecord::RecordNotFound
      false
    end
  end
end
