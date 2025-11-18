module Mutations
  class UpdateProject < BaseMutation
    argument :id, ID, required: true
    argument :name, String, required: false
    argument :description, String, required: false

    type Types::ProjectType

    def resolve(id:, name: nil, description: nil)
      project = Project.find(id)
      attrs = {}
      attrs[:name] = name if name
      attrs[:description] = description if description
      project.update!(attrs)
      project
    end
  end
end
