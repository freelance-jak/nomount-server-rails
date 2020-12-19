class Presentation < ApplicationRecord

validates :title, presence: true
validates :user, presence: true
validates :presen_date, presence: true
validates :document_path, presence: true

end
