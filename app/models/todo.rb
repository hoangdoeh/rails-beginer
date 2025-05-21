class Todo < ApplicationRecord
  validates :name, presence: true, length: { maximum: 255 }
  validates :deadline, presence: true
  validates :status, presence: true

  belongs_to :user, foreign_key: :user_id

  before_create do
    self.status = 0 if self.status.nil?
  end
end
