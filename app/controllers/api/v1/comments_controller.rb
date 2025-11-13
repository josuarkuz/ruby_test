module Api
  module V1
    class CommentsController < ApplicationController
      before_action :require_auth!

      def index
        commentable = find_commentable
        render json: commentable.comments.order(created_at: :desc)
      end

      def create
        commentable = find_commentable
        comment = commentable.comments.create!(body: params.require(:body))
        render json: comment, status: :created
      end

      private

      def find_commentable
        if params[:product_id]
          Product.find(params[:product_id])
        else
          raise ActiveRecord::RecordNotFound
        end
      end
    end
  end
end
