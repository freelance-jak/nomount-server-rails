# frozen_string_literal: true

FactoryBot.define do
  factory :event_member do
    event { nil }
    member { nil }
    status { "MyString" }
  end
end
