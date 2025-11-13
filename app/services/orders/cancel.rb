module Orders
  class Cancel
    def self.call(order:) = new(order).call
    def initialize(order) = @order = order
    def call
      raise "Order not cancellable" if @order.fulfilled?
      @order.update!(status: :cancelled)
    end
  end
end
