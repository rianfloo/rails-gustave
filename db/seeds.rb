# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "_ _ _ _ _ _ _ _ _ _"
puts "Creating the Dishes"
puts "_ _ _ _ _ _ _ _ _ _"

poulet = Dish.create(
  name: "poulet",
  photo_url: "http://www.thefoodnomads.com/wp-content/uploads/2012/09/DSC_0028.jpg")

kebab = Dish.create(
  name: "kebab",
  photo_url: "http://i1.mirror.co.uk/incoming/article804242.ece/ALTERNATES/s615/Kebab.jpg")

huitres = Dish.create(
  name: "huitres",
  photo_url: "http://fishandfiches.com/wp-content/uploads/2014/02/01-940x627.jpg")

tartiflette = Dish.create(
  name: "tartiflette",
  photo_url: "http://www.chamonix.net/sites/default/files/nodeimages/tartiflette-1.jpg?itok=Y9DczJHp")

entrecote = Dish.create(
  name: "entrecote",
  photo_url: "http://www.thenational.ae/storyimage/AB/20150122/BLOGS/150129719/AR/0/&NCS_modified=20150122105044&MaxW=640&imageVersion=default&AR-150129719.jpg")

tarte = Dish.create(
  name: "tarte au citron",
  photo_url: "http://f.tqn.com/y/frenchfood/1/W/x/N/-/-/184363437.jpg")

blanquette = Dish.create(
  name: "blanquette de veau",
  photo_url: "http://img.cac.pmdstatic.net/fit/http.3A.2F.2Fwww.2Ecuisineactuelle.2Efr.2Fvar.2Fcui.2Fstorage.2Fimages.2Frecettes-de-cuisine.2Fplat.2Fblanquette.2Fblanquette-de-veau-express-a-la-cocotte-minute-prisma_recipe-240433.2F1495456-2-fre-FR.2Fblanquette-de-veau-express-a-la-cocotte-minute.2Ejpg/734x367/crop-from/center/blanquette-de-veau-express-a-la-cocotte-minute.jpg")

lasagne = Dish.create(
  name: "lasagnes",
  photo_url: "http://img.sndimg.com/food/image/upload/w_555,h_416,c_fit,fl_progressive,q_95/v1/img/recipes/28/76/8/TxIgXfZjQXiKWNfzJV9j_lasagna.JPG")

puts "_ _ _ _ _ _ _ _ _ _"
puts "Dish created"
