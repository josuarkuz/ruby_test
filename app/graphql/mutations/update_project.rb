module Mutations
  class UpdateProject < BaseMutation
    argument :id, ID, required: true
    argument :name, String, required: false
    argument :description, String, required: false

    field :project, Types::ProjectType, null: false

    def resolve(id:, name: nil, description: nil)
      project = Project.find(id)
      attrs = {}
      attrs[:name] = name if name
      attrs[:description] = description if description
      project.update!(attrs)
      { project: project }
    end
  end
end
