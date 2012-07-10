FactoryGirl.define do
  factory :user do
    email "test@email.com"
    github_username "test"
    name "Test User"
  end
  
  factory :event do
    title "Dummy event"
    description "Dummy event description"
    at { DateTime.tomorrow }
    
    # factory :event_with_users do
    #   ignore do
    #     users_count 1
    #   end
    # 
    #   after(:create) do |event, evaluator|
    #     FactoryGirl.create_list(:user, evaluator.users_count, event: event)
    #   end
    # end
  end
end