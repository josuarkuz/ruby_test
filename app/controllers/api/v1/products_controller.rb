module Api
  module V1
    class ProductsController < ApplicationController
      before_action :require_auth!, except: %i[index show]
      before_action :set_product, only: %i[show update destroy]

      def index
        products = Product.available
        render json: products, each_serializer: ProductSerializer
      end

      def show
        render json: @product, serializer: ProductSerializer
      end

      def create
        product = Product.new(product_params)
        if product.save
          render json: product, serializer: ProductSerializer, status: :created
        else
          render json: { errors: product.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if @product.update(product_params)
          render json: @product, serializer: ProductSerializer
        else
          render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        @product.destroy!
        head :no_content
      end

      private

      def set_product
        @product = Product.find(params[:id])
      end

      def product_params
        params.require(:product).permit(:name, :sku, :price_cents, :status)
      end
    end
  end
end
