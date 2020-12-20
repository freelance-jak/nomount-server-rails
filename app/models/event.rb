# frozen_string_literal: true

class Event < ApplicationRecord
  has_many :event_members, dependent: :destroy
  has_many :members, through: :event_members, dependent: :nullify
end
