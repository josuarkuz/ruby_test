module Orders
  class Fulfill
    def self.call(order:) = new(order).call
    def initialize(order) = @order = order
    def call
      raise "Order must be paid" unless @order.paid?
      @order.update!(status: :fulfilled)
    end
  end
end
