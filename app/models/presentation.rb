# frozen_string_literal: true

class Presentation < ApplicationRecord
  mount_uploader :document_path, PresentationUploader

  validates :title, presence: true
  # validates :user, presence: true
  validates :presen_date, presence: true
  validates :document_path, presence: true
end
