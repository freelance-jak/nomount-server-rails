# frozen_string_literal: true

class Api::EventsController < ApplicationController
  before_action :set_event, only: %i[update destroy]

  def index
    @events = Event.all
    render json: @events, each_serializer: EventSerializer
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      render json: @event, serializer: EventSerializer
    else
      render json: @event.errors
    end
  end

  def update
    if @event.update(event_params)
      render json: @event, serializer: EventSerializer
    else
      render json: @event.errors
    end
  end

  def destroy
    @event.destroy
  end

  private

    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:title, :description, :start_date)
    end
end
