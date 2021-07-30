# frozen_string_literal: true

class CategoriesQuery
  attr_reader :relation

  def initialize(relation = Category.all)
    @relation = relation
  end

  def root_categories
    relation
      .where(parent_cat_id: nil)
      .where(active: true)
      .order(:id)
  end

  def listing(category_id)
    relation.find_by(id: category_id)
  end

  # Return the array of ascendants, including itself.
  def ascendants(category_id)
    category = listing(category_id)
    return [] unless category
    ascendants = []

    loop do
      parent = listing(category.parent_cat_id)
      break unless parent.present?
      ascendants.unshift(parent)
      category = parent
    end

    ascendants
  end

  def belonging_subcategories(category_id)
    relation
      .where(parent_cat_id: category_id)
      .where(active: true)
      .order(:name)
  end

  def search_listings(q)
    # Use `ILIKE` to let it searches case-insensitively, e.g. GPS can be
    # searched by 'gps'.
    query = sanitize_sql(["name ILIKE ?", "%#{q.strip}%"])

    relation
      .where(query)
      .where(active: true)
      .order(:id)
  end

  private

  def sanitize_sql(input)
    @sql_sanitizer ||= ApplicationRecord.method(:sanitize_sql_array)
    @sql_sanitizer.call(input)
  end
end
