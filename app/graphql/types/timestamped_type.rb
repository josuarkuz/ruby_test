module Types
  module TimestampedType
    include GraphQL::Schema::Interface

    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
