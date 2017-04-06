FactoryGirl.define do
  factory :donate do
    work_id 1
    price "9.99"
    donor_id 1
    bedonor_id 1
    aasm_state "MyString"
    token "MyString"
    kind 1
    has_info false
  end
end
