class Product < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true
  validates :image_url, format: {
      with: %r{\.(gif|jpg|png)$}i,
      message: 'must be an URL for GIF, JPG or PNG image.' }

  def self.platforms
    ['PC','PS3','XBOX']
  end

  def self.genres
    ['Shooter', 'Action', 'Sport', 'MMORPG', 'RPG', 'Strategy', 'Puzzle']
  end

  def self.platform(platform)
    where(platform: platform)
  end

  def self.genre(genre)
    where(genre: genre)
  end
end
