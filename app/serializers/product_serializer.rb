class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :sku, :price_cents, :status
end
