# frozen_string_literal: true

require 'rails_helper'

describe CategoryImporter do
  subject { described_class }

  describe '.call' do
    let(:data_file) do
      File.join(Rails.root, 'spec', 'fixtures', 'categories', file_name)
    end
    context "when there are existing records" do
      let(:file_name) { 'root_without_subcategories.json' }
      it "destroys all records before import" do
        expect(Category.count).to eq(0)

        subject.call(data_file)
        expect(Category.count).to eq(1)

        subject.call(data_file)
        expect(Category.count).to eq(1)
      end
    end
    context "with a category without subcategories" do
      let(:file_name) { 'root_without_subcategories.json' }
      it 'creates a root category' do
        subject.call(data_file)
        expect(Category.count).to eq(1)

        root_category = Category.first
        expect(root_category.id).to eq(999999)
        expect(root_category.first_level_cat_id).to eq(999999)
        expect(root_category.parent_cat_id).to be_nil
        expect(root_category.name).to eq('อื่นๆ')
        expect(root_category.label).to eq('อื่นๆ')
        expect(root_category.leaf).to be_truthy
        expect(root_category.cat_property_models).to eq([])
        expect(root_category.rules).to eq({})
        expect(root_category.lsc_set_id).to eq(0)
        expect(root_category.variation_cat).to be_falsey
        expect(root_category.active).to be_truthy
      end
    end
    context "with a category with a 1-level-subcategory" do
      let(:file_name) { 'root_with_1_level_subcategories.json' }
      let(:first_level_cat_id) { 3836 }
      it 'creates a root category, and a subcategory' do
        subject.call(data_file)
        expect(Category.count).to eq(2)

        root_category = Category.find(first_level_cat_id)
        expect(root_category.id).to eq(first_level_cat_id)
        expect(root_category.first_level_cat_id).to eq(first_level_cat_id)
        expect(root_category.parent_cat_id).to be_nil
        expect(root_category.name).to eq('กล้อง')
        expect(root_category.label).to eq('กล้อง')
        expect(root_category.leaf).to be_falsey
        expect(root_category.cat_property_models).to eq([])
        expect(root_category.rules).to eq({})
        expect(root_category.lsc_set_id).to eq(0)
        expect(root_category.variation_cat).to be_falsey
        expect(root_category.active).to be_truthy

        subcategory_1 = Category.find(4325)
        expect(subcategory_1.id).to eq(4325)
        expect(subcategory_1.first_level_cat_id).to eq(first_level_cat_id)
        expect(subcategory_1.parent_cat_id).to eq(first_level_cat_id)
        expect(subcategory_1.name).to eq('กล้องบริดจ์')
        expect(subcategory_1.label).to eq('กล้องบริดจ์')
        expect(subcategory_1.leaf).to be_truthy
        expect(subcategory_1.cat_property_models).to eq([])
        expect(subcategory_1.rules).to eq({})
        expect(subcategory_1.lsc_set_id).to eq(0)
        expect(subcategory_1.variation_cat).to be_falsey
        expect(subcategory_1.active).to be_truthy
      end
    end
    context "with a category with 2 1-level-subcategories" do
      let(:file_name) { 'root_with_1_level_2subcategories.json' }
      let(:first_level_cat_id) { 3836 }
      it 'creates a root category, and a subcategory' do
        subject.call(data_file)
        expect(Category.count).to eq(3)

        root_category = Category.find(first_level_cat_id)
        expect(root_category.id).to eq(first_level_cat_id)
        expect(root_category.first_level_cat_id).to eq(first_level_cat_id)
        expect(root_category.parent_cat_id).to be_nil
        expect(root_category.name).to eq('กล้อง')
        expect(root_category.label).to eq('กล้อง')
        expect(root_category.leaf).to be_falsey
        expect(root_category.cat_property_models).to eq([])
        expect(root_category.rules).to eq({})
        expect(root_category.lsc_set_id).to eq(0)
        expect(root_category.variation_cat).to be_falsey
        expect(root_category.active).to be_truthy

        subcategory_1_1 = Category.find(4325)
        expect(subcategory_1_1.id).to eq(4325)
        expect(subcategory_1_1.first_level_cat_id).to eq(first_level_cat_id)
        expect(subcategory_1_1.parent_cat_id).to eq(first_level_cat_id)
        expect(subcategory_1_1.name).to eq('กล้องบริดจ์')
        expect(subcategory_1_1.label).to eq('กล้องบริดจ์')
        expect(subcategory_1_1.leaf).to be_truthy
        expect(subcategory_1_1.cat_property_models).to eq([])
        expect(subcategory_1_1.rules).to eq({})
        expect(subcategory_1_1.lsc_set_id).to eq(0)
        expect(subcategory_1_1.variation_cat).to be_falsey
        expect(subcategory_1_1.active).to be_truthy

        subcategory_1_2 = Category.find(14445)
        expect(subcategory_1_2.id).to eq(14445)
        expect(subcategory_1_2.first_level_cat_id).to eq(first_level_cat_id)
        expect(subcategory_1_2.parent_cat_id).to eq(first_level_cat_id)
        expect(subcategory_1_2.name).to eq('กล้องติดรถยนต์')
        expect(subcategory_1_2.label).to eq('กล้องติดรถยนต์')
        expect(subcategory_1_2.leaf).to be_truthy
        expect(subcategory_1_2.cat_property_models).to eq([])
        expect(subcategory_1_2.rules).to eq({})
        expect(subcategory_1_2.lsc_set_id).to eq(0)
        expect(subcategory_1_2.variation_cat).to be_falsey
        expect(subcategory_1_2.active).to be_truthy
      end
    end
    context "with a category with 2-level subcategories" do
      let(:file_name) { 'root_with_2_level_subcategories.json' }
      let(:first_level_cat_id) { 9154 }
      it 'creates a root category, and 2 subcategories' do
        subject.call(data_file)
        expect(Category.count).to eq(3)

        root_category = Category.find(first_level_cat_id)
        expect(root_category.id).to eq(first_level_cat_id)
        expect(root_category.first_level_cat_id).to eq(first_level_cat_id)
        expect(root_category.parent_cat_id).to be_nil
        expect(root_category.name).to eq('กระเป๋า & กระเป๋าเดินทาง')
        expect(root_category.label).to eq('กระเป๋า & กระเป๋าเดินทาง')
        expect(root_category.leaf).to be_falsey
        expect(root_category.cat_property_models).to eq([])
        expect(root_category.rules).to eq({})
        expect(root_category.lsc_set_id).to eq(0)
        expect(root_category.variation_cat).to be_falsey
        expect(root_category.active).to be_truthy

        subcategory_1 = Category.find(13423)
        expect(subcategory_1.id).to eq(13423)
        expect(subcategory_1.first_level_cat_id).to eq(first_level_cat_id)
        expect(subcategory_1.parent_cat_id).to eq(first_level_cat_id)
        expect(subcategory_1.name).to eq('กระเป๋าเด็ก')
        expect(subcategory_1.label).to eq('กระเป๋าเด็ก')
        expect(subcategory_1.leaf).to be_falsey
        expect(subcategory_1.cat_property_models).to eq([])
        expect(subcategory_1.rules).to eq({})
        expect(subcategory_1.lsc_set_id).to eq(0)
        expect(subcategory_1.variation_cat).to be_falsey
        expect(subcategory_1.active).to be_truthy

        subcategory_2 = Category.find(13451)
        expect(subcategory_2.id).to eq(13451)
        expect(subcategory_2.first_level_cat_id).to eq(first_level_cat_id)
        expect(subcategory_2.parent_cat_id).to eq(13423)
        expect(subcategory_2.name).to eq('ขวดน้ำสำหรับเด็ก')
        expect(subcategory_2.label).to eq('ขวดน้ำสำหรับเด็ก')
        expect(subcategory_2.leaf).to be_truthy
        expect(subcategory_2.cat_property_models).to eq([])
        expect(subcategory_2.rules).to eq({})
        expect(subcategory_2.lsc_set_id).to eq(0)
        expect(subcategory_2.variation_cat).to be_falsey
        expect(subcategory_2.active).to be_truthy
      end
    end
    context "with a category with 3-level subcategories" do
      let(:file_name) { 'root_with_3_level_subcategories.json' }
      let(:first_level_cat_id) { 9154 }
      it 'creates a root category, and 3 subcategories' do
        subject.call(data_file)
        expect(Category.count).to eq(4)

        root_category = Category.find(first_level_cat_id)
        expect(root_category.id).to eq(first_level_cat_id)
        expect(root_category.first_level_cat_id).to eq(first_level_cat_id)
        expect(root_category.parent_cat_id).to be_nil
        expect(root_category.name).to eq('กระเป๋า & กระเป๋าเดินทาง')
        expect(root_category.label).to eq('กระเป๋า & กระเป๋าเดินทาง')
        expect(root_category.leaf).to be_falsey
        expect(root_category.cat_property_models).to eq([])
        expect(root_category.rules).to eq({})
        expect(root_category.lsc_set_id).to eq(0)
        expect(root_category.variation_cat).to be_falsey
        expect(root_category.active).to be_truthy

        subcategory_1 = Category.find(13421)
        expect(subcategory_1.id).to eq(13421)
        expect(subcategory_1.first_level_cat_id).to eq(first_level_cat_id)
        expect(subcategory_1.parent_cat_id).to eq(first_level_cat_id)
        expect(subcategory_1.name).to eq('กระเป๋าผู้ชาย')
        expect(subcategory_1.label).to eq('กระเป๋าผู้ชาย')
        expect(subcategory_1.leaf).to be_falsey
        expect(subcategory_1.cat_property_models).to eq([])
        expect(subcategory_1.rules).to eq({})
        expect(subcategory_1.lsc_set_id).to eq(0)
        expect(subcategory_1.variation_cat).to be_falsey
        expect(subcategory_1.active).to be_truthy

        subcategory_2 = Category.find(13440)
        expect(subcategory_2.id).to eq(13440)
        expect(subcategory_2.first_level_cat_id).to eq(first_level_cat_id)
        expect(subcategory_2.parent_cat_id).to eq(13421)
        expect(subcategory_2.name).to eq('กระเป๋าเป้สะพายหลัง')
        expect(subcategory_2.label).to eq('กระเป๋าเป้สะพายหลัง')
        expect(subcategory_2.leaf).to be_falsey
        expect(subcategory_2.cat_property_models).to eq([])
        expect(subcategory_2.rules).to eq({})
        expect(subcategory_2.lsc_set_id).to eq(0)
        expect(subcategory_2.variation_cat).to be_falsey
        expect(subcategory_2.active).to be_truthy

        subcategory_3 = Category.find(13483)
        expect(subcategory_3.id).to eq(13483)
        expect(subcategory_3.first_level_cat_id).to eq(first_level_cat_id)
        expect(subcategory_3.parent_cat_id).to eq(13440)
        expect(subcategory_3.name).to eq('กระเป๋าเป้ แฟชั่น')
        expect(subcategory_3.label).to eq('กระเป๋าเป้ แฟชั่น')
        expect(subcategory_3.leaf).to be_truthy
        expect(subcategory_3.cat_property_models).to eq([])
        expect(subcategory_3.rules).to eq({})
        expect(subcategory_3.lsc_set_id).to eq(0)
        expect(subcategory_3.variation_cat).to be_truthy
        expect(subcategory_3.active).to be_truthy
      end
    end
    context "with a category with 10-level subcategories" do
      let(:file_name) { 'root_with_10_level_subcategories.json' }
      let(:first_level_cat_id) { 1000 }
      it 'creates a root category, and 10 subcategories' do
        subject.call(data_file)
        expect(Category.count).to eq(11)

        # Root category
        root_category = Category.find(first_level_cat_id)
        expect(root_category.id).to eq(first_level_cat_id)
        expect(root_category.first_level_cat_id).to eq(first_level_cat_id)
        expect(root_category.parent_cat_id).to be_nil
        expect(root_category.name).to eq('root category')
        expect(root_category.label).to eq('root category')
        expect(root_category.leaf).to be_falsey
        expect(root_category.cat_property_models).to eq([])
        expect(root_category.rules).to eq({})
        expect(root_category.lsc_set_id).to eq(0)
        expect(root_category.variation_cat).to be_falsey
        expect(root_category.active).to be_truthy

        # Intermediate subcategories in level 1 - 9
        (1..9).each do |level_number|
          category_id = "100#{level_number}".to_i
          parent_cat_id = "100#{level_number - 1}".to_i

          subcategory = Category.find(category_id)
          expect(subcategory.id).to eq(category_id)
          expect(subcategory.first_level_cat_id).to eq(first_level_cat_id)
          expect(subcategory.parent_cat_id).to eq(parent_cat_id)
          expect(subcategory.name).to eq("subcategory #{level_number}")
          expect(subcategory.label).to eq("subcategory #{level_number}")
          expect(subcategory.leaf).to be_falsey
          expect(subcategory.cat_property_models).to eq([])
          expect(subcategory.rules).to eq({})
          expect(subcategory.lsc_set_id).to eq(0)
          expect(subcategory.variation_cat).to be_falsey
          expect(subcategory.active).to be_truthy
        end

        # Leaf category which is on level 10
        subcategory_10 = Category.find(1010)
        expect(subcategory_10.id).to eq(1010)
        expect(subcategory_10.first_level_cat_id).to eq(first_level_cat_id)
        expect(subcategory_10.parent_cat_id).to eq(1009)
        expect(subcategory_10.name).to eq('subcategory 10')
        expect(subcategory_10.label).to eq('subcategory 10')
        expect(subcategory_10.leaf).to be_truthy
        expect(subcategory_10.cat_property_models).to eq([])
        expect(subcategory_10.rules).to eq({})
        expect(subcategory_10.lsc_set_id).to eq(0)
        expect(subcategory_10.variation_cat).to be_falsey
        expect(subcategory_10.active).to be_truthy
      end
    end
    context "when a category has wrong defined 'isLeaf'" do
      let(:file_name) { 'root_with_1_level_subcategories_wrong_isleaf.json' }
      let(:first_level_cat_id) { 3836 }
      it 'creates a root category, and a subcategory' do
        expect { subject.call(data_file) }
          .to raise_error(CategoryImporter::WrongDefinedLeafNode)
      end
    end
  end
end
