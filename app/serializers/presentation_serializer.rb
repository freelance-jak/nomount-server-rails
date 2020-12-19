class PresentationSerializer < ActiveModel::Serializer
  attributes :id, :title, :user_id, :presen_date, :document_path
end
