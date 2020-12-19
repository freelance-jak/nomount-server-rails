class Member < ApplicationRecord
  has_many :events, through: :event_members, dependent: :nullify
  has_many :events, dependent: :destroy
end
