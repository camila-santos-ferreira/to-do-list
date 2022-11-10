FactoryBot.define do
  factory :task do
    name { 'Task' }
    status { 'pending' }
  end

  trait :done do
    status { 'done' }
  end

  trait :pending do
    status { 'pending' }
  end
end
