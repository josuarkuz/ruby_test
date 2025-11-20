module Mutations
  class CreateProject < BaseMutation
    argument :name, String, required: true
    argument :description, String, required: false

    field :project, Types::ProjectType, null: false

    def resolve(name:, description: nil)
      project = Project.create!(name:, description:)
      { project: project }
    end
  end
end
