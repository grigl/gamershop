namespace :db do
  desc "Fill database with simple data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    make_users
    make_products
  end
end

def make_users
  User.create({ email: 'griglmail@gmail.com',
                username: 'grigl',
                password: 'wrle2la5',
                password_confirmation: 'wrle2la5',
                active: true,
                admin: true },
                without_protection: true)
end

def make_products
  99.times do
    product = Product.new
    product.title = Faker::Lorem.sentence(2)
    product.price = 34.99
    product.platform = ['PC','PS3','XBOX'][rand(3)]
    product.released_date = '12.05.2011'
    product.genre = ['Shooter', 'Action', 'Sport', 'MMORPG', 'RPG', 'Strategy', 'Puzzle'][rand(7)]
    product.description = Faker::Lorem.sentence(40)
    product.publisher = 'Bethesda'
    product.developer = 'Rockstar'
    product.image_url = "game_#{rand(5)}.jpg"
    product.save
  end                       
end