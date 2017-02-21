FactoryGirl.define do
  factory :tweet do
    twitter_id 1234
    active true
    why "Because this is a good frame"
    full_text "Tweeting about #hashtag"
  end
end
