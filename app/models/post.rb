class Post < ApplicationRecord
  belongs_to :user
  validates :title, :expiration_date, presence: true
end
