class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  enum :status, { pending: 0, paid: 1, fulfilled: 2, cancelled: 3 }

  validates :total_cents, numericality: { greater_than_or_equal_to: 0 }

  scope :recent, -> { order(created_at: :desc) }

  def recalc_total!
    update!(total_cents: order_items.sum("quantity * price_cents"))
  end
end
