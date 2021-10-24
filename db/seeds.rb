# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'open-uri'
require 'json'

Bookmark.destroy_all
Movie.destroy_all

CONFIG = 'http://tmdb.lewagon.com/configuration'
TOP = 'http://tmdb.lewagon.com/movie/top_rated'

config_json = URI.open(CONFIG).read
config_hash = JSON.parse(config_json)

BASE_URL = config_hash['images']['base_url']
POSTER_SIZE = config_hash['images']['poster_sizes'][3]

top_rated = URI.open(TOP).read
top_rated_hash = JSON.parse(top_rated)

top_rated_hash['results'].each do |movie|
  Movie.create(
    title: movie['original_title'],
    overview: movie['overview'],
    poster_url: BASE_URL + POSTER_SIZE + movie['poster_path'],
    rating: movie['vote_average']
  )
end

List.destroy_all

rand(2..20).times do
  list = List.create(
    name: Faker::Lorem.words(number: 10).sample
  )
  rand(2..20).times do
    list.bookmarks.create(
      comment: "Recommended",
      movie_id: Movie.find(rand(Movie.first.id..Movie.last.id)).id
    )
  end
end
