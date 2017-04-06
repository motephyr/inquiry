FactoryGirl.define do
  factory :user do
    sequence :name do |n|
      "user_#{n}"
    end

    sequence :email do |n|
      "email+#{n}@solda.io"
    end
    password  "password"

  end
end
