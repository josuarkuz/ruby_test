module Orders
  class Pay
    def self.call(order:) = new(order).call

    def initialize(order) = @order = order

    def call
      raise "Order not pending" unless @order.pending?
      # integrate payment gateway here
      @order.update!(status: :paid)
    end
  end
end
