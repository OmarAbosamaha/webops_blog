FactoryBot.define do
  factory :post do
    user
    body { 'body' }
    title { 'title' }
  end
end
