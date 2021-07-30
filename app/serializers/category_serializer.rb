# frozen_string_literal: true

class CategorySerializer
  def listings(categories)
    options = categories.map do |category|
      listing(category)
    end

    {
      listings: options
    }
  end

  def listing(category)
    {
      id: category.id,
      name: category.name
    }
  end

  def item_details(category)
    {
      id: category.id,
      firstLevelCatId: category.first_level_cat_id,
      parentCatId: category.parent_cat_id,
      name: category.name,
      label: category.label,
      isLeaf: category.leaf,
      catPropertyModels: category.cat_property_models,
      rules: category.rules,
      lscSetId: category.lsc_set_id,
      variationCat: category.variation_cat,
      active: category.active
    }
  end
end
