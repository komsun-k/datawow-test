# frozen_string_literal: true

namespace :data do
  desc 'Import categories from json file'
  task seed_categories: :environment do
    file_name = File.join(Rails.root, 'data', 'categories.json')
    unless File.exist?(file_name)
      puts 'categories.json does not exist!'
      exit 1
    end

    puts 'Importing...'

    CategoryImporter.call(file_name)

    puts "Done importing categories.json. Total is #{Category.count} items"
  end
end
