# frozen_string_literal: true

User.destroy_all

USER_COUNT = 5
user_ids = []

USER_COUNT.times do |n|
  count = n + 1
  user = User.new(name: "名前#{count}", user_name: "ユーザ名#{count}", email: "example#{count}@example.com",
                  password: "#{'a' * count}111111")
  user.skip_confirmation!
  user.save!(context: :omniauth)
  user_ids << user.id
end

50.times do |n|
  post = Post.create!(
    user_id: user_ids.sample,
    content: "テスト投稿#{n}です。"
  )
end
