module Mutations
  class BaseMutation < GraphQL::Schema::RelayClassicMutation
    null false

    private

    def current_user
      context[:current_user]
    end
  end
end
