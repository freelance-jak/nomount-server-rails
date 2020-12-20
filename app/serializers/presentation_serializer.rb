# frozen_string_literal: true

class PresentationSerializer < ActiveModel::Serializer
  attributes :id, :title, :user, :presen_date, :document_path
end
