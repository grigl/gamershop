class Product < ActiveRecord::Base
  has_many :line_items
  
  validates :title, presence: true, uniqueness: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :image_url, format: {
      with: %r{\.(gif|jpg|png)$}i,
      message: 'must be an URL for GIF, JPG or PNG image.' }

  def self.platforms
    ['PC','PS3','XBOX']
  end

  def self.genres
    ['Shooter', 'Action', 'Sport', 'MMORPG', 'RPG', 'Strategy', 'Puzzle']
  end

  def self.ordering
    { columns: ['released_date', 'title', 'price'], default: 'released_date' }
  end

  def self.platform(platform)
    where(platform: platform)
  end

  def self.genre(genre)
    where(genre: genre)
  end

end
