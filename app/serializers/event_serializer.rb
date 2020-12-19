class EventSerializer < ActiveModel::Serializer
  attributes :title, :description, :start_date
end