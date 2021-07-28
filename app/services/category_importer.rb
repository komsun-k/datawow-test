# frozen_string_literal: true

class CategoryImporter
  WrongDefinedLeafNode = Class.new(StandardError)

  def self.call(data_file)
    new(data_file).perform
  end

  def initialize(data_file)
    @data_file = data_file
  end

  def perform
    Category.destroy_all

    JSON.parse(File.read(@data_file)).each_with_index do |root_item, index|
      save_categories(root_item, parent_cat_id: nil)
    end
  end

  private

  def save_categories(category_item, parent_cat_id:)
    create_category(category_item, parent_cat_id: parent_cat_id)

    if category_item["subcategories"].present?
      if category_item["isLeaf"]
        raise WrongDefinedLeafNode,
          "Wrong defined 'isLeaf' on item##{category_item["id"]}. Please retry."
      end
      category_item["subcategories"].each do |subcategory|
        save_categories(subcategory, parent_cat_id: category_item["id"])
      end
    end
  end

  def create_category(category_item, parent_cat_id:)
    Category.create!(
      id: category_item["id"],
      first_level_cat_id: category_item["firstLevelCatId"],
      parent_cat_id: parent_cat_id,
      name: category_item["name"],
      label: category_item["label"],
      leaf: category_item["isLeaf"],
      cat_property_models: category_item["catPropertyModels"],
      rules: category_item["rules"],
      lsc_set_id: category_item["lscSetId"],
      variation_cat: category_item["variationCat"],
      active: category_item["active"],
    )
  end
end
