# frozen_string_literal: true

User.destroy_all

5.times do |n|
  user = User.new(name: "名前#{n}", user_name: "ユーザ名#{n}", email: "example#{n}@example.com",
                  password: "#{'a' * n}111111")
  user.skip_confirmation!
  user.save!(context: :omniauth)
end
