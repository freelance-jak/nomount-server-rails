# frozen_string_literal: true

require "csv"

class Api::MembersController < ApplicationController
  def create
    event = Event.find(params[:event_id])
    ActiveRecord::Base.transaction do
      csv_path = "#{Rails.root}/app/assets/csv/join.csv" # 仮置き
      CSV.foreach(csv_path, headers: true) do |csv|
        member = Member.find_by(connpass_account: csv["ユーザー名"])
        unless member
          member = Member.create!(connpass_account: csv["ユーザー名"], name: csv["表示名"])
        end
        status = (csv["参加ステータス"] == "参加キャンセル") ? "cancel" : "wait"
        event_member = EventMember.new(member: member, event: event, status: status)
        return next unless event_member.valid?

        event_member.save!
      end
    end
  end
end
