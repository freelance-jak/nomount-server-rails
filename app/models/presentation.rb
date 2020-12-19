class Presentation < ApplicationRecord
	validates :user_id, presence: true
	validates :title, presence: true, length: { in: 5..50 }
	validates :presen_date, presence: true
	validates :document_path, presence: true
end
