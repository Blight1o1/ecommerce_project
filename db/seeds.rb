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

#  ==== CSV ==== #
#   For Games   #
csv_file = Rails.root.join('db/games.csv')
csv_data = File.read(csv_file)

games = CSV.parse(csv_data, headers: true, encoding: 'iso-8859-1')

games.each do |game|
    if game[0] != nil
        description = game[0] + " is made by " + game[8] + " in " + game[15] + "."
        new_game = Game.create(name: game[0], description: description , price: game[11], score: game[9], rating: game[13])
        #puts new_type.name
    end

end
puts "Entered Games data"

#  ==== CSV ==== #
#   For Genres   #
csv_file = Rails.root.join('db/genres.csv')
csv_data = File.read(csv_file)

genres = CSV.parse(csv_data, headers: true, encoding: 'iso-8859-1')

genres.each do |genre|
    if genre[0] != nil
        title = genre[2].first(genre[2].index(':'))
        content = genre[2].from(genre[2].index(':'))
        new_genre = Game.create(name: title, description: content)
        #puts new_type.name
    end

end
puts "Entered Genre data"