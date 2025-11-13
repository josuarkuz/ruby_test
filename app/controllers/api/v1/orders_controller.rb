module Api
  module V1
    class OrdersController < ApplicationController
      before_action :require_auth!
      before_action :set_order, only: %i[show update pay fulfill cancel]

      def index
        orders = current_user.orders.recent.includes(:order_items)
        render json: orders.as_json(include: { order_items: { include: :product } })
      end

      def show
        render json: @order.as_json(include: { order_items: { include: :product } })
      end

      def create
        order = Orders::Create.call(user: current_user, items: order_items_params)
        render json: order.as_json(include: { order_items: { include: :product } }), status: :created
      rescue Orders::Create::Error => e
        render json: { error: e.message }, status: :unprocessable_entity
      end

      def update
        if @order.update(order_params)
          @order.recalc_total!
          render json: @order
        else
          render json: { errors: @order.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def pay
        Orders::Pay.call(order: @order)
        render json: @order
      end

      def fulfill
        Orders::Fulfill.call(order: @order)
        render json: @order
      end

      def cancel
        Orders::Cancel.call(order: @order)
        render json: @order
      end

      private

      def set_order
        @order = current_user.orders.find(params[:id])
      end

      def order_params
        params.require(:order).permit(:status)
      end

      def order_items_params
        # expects [{ product_id, quantity }]
        params.require(:items).map { _1.permit(:product_id, :quantity) }
      end
    end
  end
end
