# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
require 'csv'
require 'net/http'
require 'json'
require 'pp'

#User.destroy_all
Province.destroy_all
GamePlatform.destroy_all
GameGenre.destroy_all
Platform.destroy_all
Genre.destroy_all
Game.destroy_all
puts "Purged data"


#   ==== Faker ==== #
#   For Platform.   #
Faker::Name.unique.clear 
Faker::UniqueGenerator.clear
count = 0

31.times do
    platform = Platform.create(name: Faker::Game.unique.platform)
    #puts count
    count = count + 1
end
puts "Entered Platform data"

#  ==== CSV ==== #
#   For Genres   #
csv_file = Rails.root.join('db/genres.csv')
csv_data = File.read(csv_file)

genres = CSV.parse(csv_data, headers: true)#, encoding: 'iso-8859-1'

genres.each do |genre|
    if genre[0] != nil
        title = genre[2].first(genre[2].index(':'))
        content = genre[2].from(genre[2].index(':') + 2)
        new_genre = Genre.create(name: title, description: content)
    end

end
puts "Entered Genre data"

#  ==== CSV ==== #
#   For Games   #
csv_file = Rails.root.join('db/games.csv')
csv_data = File.read(csv_file)

games = CSV.parse(csv_data, headers: true, encoding: 'iso-8859-1')

games.each do |game|
    if game[0] != nil

        game_exists = Game.find_by(name: game[0])

        if (game_exists == nil)
            publisher = game[7]
            if publisher == nil
                publisher = "unknown"
            end
            description = game[0] + " is made by " + publisher + " in " + game[15] + "."
            new_game = Game.create(name: game[0], description: description , price: game[11], score: game[9], rating: game[13])

            game_genres = game[5].split(',')
            #==== Connection between Games and Genre ====#
            game_genres.each do |x|
                filter_name = x.split
                genre_of_game = Genre.find_by(name: filter_name[0])
                GameGenre.create(game: new_game, genre: genre_of_game)
            end

            game_platforms = game[12]
            if(game_platforms == "X360")
                game_platforms = "Xbox 360"
            end
            if(game_platforms == "Sony PSP")
                game_platforms = "PlayStation Portable"
            end
            if(game_platforms == "Nintendo Wii")
                game_platforms = "Wii"
            end
            #==== Connection between Games and Platform ====#
            console = Platform.find_or_create_by(name: game_platforms)
            GamePlatform.create(game: new_game, platform: console)
        else 
            game_platforms = game[12]
            if(game_platforms == "X360")
                game_platforms = "Xbox 360"
            end
            if(game_platforms == "Sony PSP")
                game_platforms = "PlayStation Portable"
            end
            if(game_platforms == "Nintendo Wii")
                game_platforms = "Wii"
            end
            #==== Connection between Games and Platform ====#
            console = Platform.find_or_create_by(name: game_platforms)
            GamePlatform.create(game: game_exists, platform: console)
        end

    end
end
puts "Entered Games data"

#  ==== CSV ==== #
#   For Games   #
csv_file = Rails.root.join('db/taxes.csv')
csv_data = File.read(csv_file)

province = CSV.parse(csv_data, headers: true, encoding: 'iso-8859-1')

province.each do |province|
    Province.create(name: province[0], pst: province[2], gst: province[3], hst: province[4], total_tax: province[5])
end

puts "Entered Province data"


#AdminUser.create!(email: 'jordan@blight.ca', password: 'mypassword', password_confirmation: 'mypassword') if Rails.env.development?