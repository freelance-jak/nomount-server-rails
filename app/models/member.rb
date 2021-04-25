# frozen_string_literal: true

class Member < ApplicationRecord
  has_many :event_members, dependent: :destroy
  has_many :events, through: :event_members, dependent: :nullify
end
