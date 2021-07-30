# frozen_string_literal: true

module Api
  class CategoriesController < ApplicationController
    def show
      raise "Need 'params[:id]'" unless category_id.present?

      @listing = CategoriesQuery.new.listing(category_id)

      render json: {
        listing: CategorySerializer.new.item_details(@listing)
      }
    end

    private

    def category_id
      params[:id]
    end
  end
end
