# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :account do
    subdomain { Forgery(:name).company_name.downcase }
  end

  # factory :account_with_users do
    # after(:build) do |account|
      
  # end
end
