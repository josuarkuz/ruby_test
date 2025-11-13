module Orders
  class Create
    class Error < StandardError; end

    def self.call(user:, items:)
      new(user:, items:).call
    end

    def initialize(user:, items:)
      @user = user
      @items = items
    end

    def call
      Order.transaction do
        order = @user.orders.create!
        @items.each do |i|
          product = Product.find(i[:product_id])
          price = product.price_cents
          qty = i[:quantity].to_i
          raise Error, "Invalid quantity" if qty <= 0
          order.order_items.create!(product:, quantity: qty, price_cents: price)
        end
        order.recalc_total!
        order
      end
    rescue ActiveRecord::RecordInvalid => e
      raise Error, e.record.errors.full_messages.to_sentence
    end
  end
end
