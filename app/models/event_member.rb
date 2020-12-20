# frozen_string_literal: true

class EventMember < ApplicationRecord
  belongs_to :event
  belongs_to :member

  enum status: { wait: "wait", participate: "participate", cancel: "cancel", flaked_out: "flaked_out" }

  validates :event_id, uniqueness: { scope: :member_id } # rubocop:disable Rails/UniqueValidationWithoutIndex
end
