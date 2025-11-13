class Product < ApplicationRecord
  has_many :order_items, dependent: :restrict_with_error
  has_many :comments, as: :commentable, dependent: :destroy

  enum :status, { draft: 0, active: 1, discontinued: 2 }

  validates :name, :sku, presence: true
  validates :sku, uniqueness: true
  validates :price_cents, numericality: { greater_than_or_equal_to: 0 }

  scope :available, -> { active.where("price_cents > 0") }
end
