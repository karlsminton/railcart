class Image < ApplicationRecord
  belongs_to :product

  def path
    data = read_attribute(:path)
    data['app/assets/images/'] = ''
    data
  end
end
