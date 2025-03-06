puts "Seeding categories..."

categories = ["Food", "Utilities", "Transportation", "Entertainment", "Other"]

categories.each do |cat|
  Category.find_or_create_by!(name: cat)
  puts "Created category: #{cat}"
end

puts "Categories seeded: #{Category.pluck(:id, :name)}"

