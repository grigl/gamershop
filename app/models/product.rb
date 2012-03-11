class Product < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true
  validates :image_url, format: {
      with: %r{\.(gif|jpg|png)$}i,
      message: 'must be an URL for GIF, JPG or PNG image.' }
end
