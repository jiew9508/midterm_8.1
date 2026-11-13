class Article < ApplicationRecord
  TOPICS = ['Cloud', 'Programming', 'Cybersecurity', 'Projects'].freeze

  has_many :comments, dependent: :destroy
  validates :title, presence: true, length: { minimum: 5, maximum: 150 }
  validates :body, presence: true, length: { minimum: 20 }
  validates :topic, presence: true, inclusion: { in: TOPICS }

end
