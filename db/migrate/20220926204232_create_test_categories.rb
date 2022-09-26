# class CreateTestCategories creates sample data
class CreateTestCategories < ActiveRecord::Migration[7.0]
  def change
    # would change this to API call but to save time ..
    description = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque a mattis lorem. Quisque lorem dolor, malesuada ut turpis et, condimentum pellentesque velit. Aliquam pulvinar semper est, at mattis enim sodales et. Morbi porta quam non ipsum dictum semper. Nam vitae lacus augue. Quisque a elit nunc. Quisque scelerisque, leo vitae maximus tempor, odio diam suscipit sem, ut vulputate ex nunc sit amet augue. Sed vulputate mattis tellus, id rhoncus nunc. Phasellus lobortis et mi a sollicitudin. Proin porttitor mauris quis sapien venenatis, efficitur vehicula ante auctor.'
    data = [
      { name: 'T-Shirts', url: 'tshirts' },
      { name: 'Jackets', url: 'jackets' },
      { name: 'Trousers', url: 'trousers' },
      { name: 'Shorts', url: 'shorts' },
      { name: 'Hoodies', url: 'hoodies' },
      { name: 'Shoes', url: 'shoes' },
      { name: 'Accessories', url: 'accessories' }
    ]
    data.each do |item|
      item[:description] = description
      Category.new(item).save
    end
  end
end
