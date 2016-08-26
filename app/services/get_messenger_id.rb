class GetMessengerId < ServiceBase
  attr_accessor :messenger_id

  def initialize(messenger_id)
    @messenger_id = messenger_id
  end

  def run
    facebook_hash(@messenger_id)
  end

  private

  def facebook_hash(messenger_id)
    # url  = "https://graph.facebook.com/v2.6/#{messenger_id}?access_token=ENV['ACCESS_TOKEN']"
    url = "https://graph.facebook.com/v2.6/#{messenger_id}?fields=first_name,last_name,profile_pic,locale,timezone,gender&access_token=#{ENV['ACCESS_TOKEN']}"
    r = RestClient.get url
    hash = JSON.parse(r)
    hash.except!("timezone", "gender", "locale")
    hash.merge!(uniq_facebook: UniqFacebook.run(hash["profile_pic"]))
  end
end

# hash = {
#   first_name: "Jérémy",
#   last_name: "F. Goillot",
#   profile_pic: "https://scontent.xx.fbcdn.net/v/t1.0-1/p200x200/13221535_1343140422369075_3008693859937895325_n.jpg?oh=c0c7e43f865e15044331281ef87e9ccc&oe=585DA37D",
#   uniq_facebook: 13221535_1343140422369075_3008693859937895325_n.jpg
# }
