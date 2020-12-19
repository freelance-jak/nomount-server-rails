class EventMember < ApplicationRecord
  belongs_to :event
  belongs_to :member

  enum status: { wait: "wait", join: "join", cancel: "cancel", flaked_out: "flaked_out" }
end
