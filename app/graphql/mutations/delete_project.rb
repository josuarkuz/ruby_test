module Mutations
  class DeleteProject < BaseMutation
    argument :id, ID, required: true
    
    field :project, Types::ProjectType, null: true
    field :success, Boolean, null: false

    def resolve(id:)
      project = Project.find(id)
      return { project: nil, success: false } unless task

      project.destroy
      { project: project, success: true }
    end
  end
end
