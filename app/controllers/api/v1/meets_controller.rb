class Api::V1::MeetsController < ApplicationController
  # NOTE: とりあえずのモック
  def show
    event = Event.first
    event_members = EventMember.where(event: event).includes(:event, :member)
    join_members = event_members.map do |em|
      {
        member:
        {
          connpass_account: em.member.connpass_account,
          name: em.member.name,
        },
        message: em.message,
        is_joining: em.status,
      }
    end
    render json: { meets: join_members }
  end
end
