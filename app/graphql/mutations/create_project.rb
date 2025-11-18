module Mutations
  class CreateProject < BaseMutation
    argument :name, String, required: true
    argument :description, String, required: false

    type Types::ProjectType

    def resolve(name:, description: nil)
      Project.create!(name:, description:)
    end
  end
end
