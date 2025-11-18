module Mutations
  class UpdateTask < BaseMutation
    argument :id, ID, required: true
    argument :title, String, required: false
    argument :description, String, required: false
    argument :status, String, required: false
    argument :assignee_id, ID, required: false

    type Types::TaskType

    def resolve(id:, title: nil, description: nil, status: nil, assignee_id: nil)
      task = Task.find(id)

      attrs = {}
      attrs[:title] = title if title
      attrs[:description] = description if description
      attrs[:status] = status if status

      if assignee_id
        attrs[:assignee] = User.find_by(id: assignee_id)
      end

      task.update!(attrs)
      task
    end
  end
end
