require 'nokogiri'
require 'open-uri'
require 'pry-byebug'
require 'rest-client'
require 'json'
require 'rails'

user_data = []

user_facebook = 871864456251617

url  = "https://graph.facebook.com/v2.6/#{user_facebook}?access_token=EAAY3zbgCSw8BAOaChwA9uKnBW0AOaqMfv2MFNkNMVtfR2yJvrx87axzXW4ImgDmjgtHAkyBrfUQIZBxgNDEK3jix3oQg6W810iHe0SUjVUbZB9gQXt2in3RRlmWvzU4NCEDMJbYl8hy7qlOHR0ny3chtVBCaTnNnBxbZBFzfQZDZD"

r = RestClient.get url

hash = JSON.parse(r)
hash.except!("profile_pic", "timezone", "gender", "locale")

# User.create(hash)

