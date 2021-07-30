# frozen_string_literal: true

module Api
  class SearchRequestsController < ApplicationController
    def index
      @categories = CategoriesQuery.new.search_listings(search_string)

      render json: {
        listings: CategorySerializer.new.listings(@categories)[:listings]
      }
    end

    def show
      raise "Need 'params[:id]'" unless category_id.present?

      @ascendants = CategoriesQuery.new.ascendants(category_id)
      @subcategories = CategoriesQuery.new.belonging_subcategories(category_id)

      render json: {
        ascendants: CategorySerializer.new.listings(@ascendants),
        subcategories: CategorySerializer.new.listings(@subcategories)
      }
    end

    private

    def category_id
      params[:id]
    end

    def search_string
      params[:q]
    end
  end
end
