# frozen_string_literal: true

User.destroy_all

USER_COUNT = 5
user_ids = []

USER_COUNT.times do |n|
  count = n + 1
  user = User.new(name: "名前#{count}", user_name: "ユーザ名#{count}", email: "example#{count}@example.com",
                  password: "#{'a' * count}111111", introduction: "自己紹介文です", place: "東京都", website: "google.com", birthdate: "2000-01-01")
  user.skip_confirmation!
  user.save!(context: :omniauth)
  user_ids << user.id
end

50.times do |n|
  Post.create!(
    user_id: user_ids.sample,
    content: "テスト投稿#{n}です。<br>テスト投稿#{n}です。<br>テスト投稿#{n}です。"
  )
end

user_ids.each do |user_id|
  followee_ids = user_ids.reject { |id| id == user_id }.sample(3)
  followee_ids.each { |followee_id| Follow.create!(follower_id: user_id, followee_id:) }
end
