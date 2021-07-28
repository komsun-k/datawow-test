# frozen_string_literal: true

class Category < ApplicationRecord
  validates :first_level_cat_id, presence: true
  validates :name, presence: true
  validates :label, presence: true
  validates :lsc_set_id, presence: true

  def root_category?
    parent_cat_id.nil?
  end
end
