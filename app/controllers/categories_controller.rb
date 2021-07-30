# frozen_string_literal: true

class CategoriesController < ApplicationController
  def index
    categories = CategoriesQuery.new.root_categories
    @root_categories = CategorySerializer.new.listings(categories)
  end
end
