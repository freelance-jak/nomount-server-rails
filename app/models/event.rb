class Event < ApplicationRecord
  has_many :members, through: :event_members, dependent: :nullify
  has_many :event_members, dependent: :destroy
end
