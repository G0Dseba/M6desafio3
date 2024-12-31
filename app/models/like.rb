class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :kind, presence: true, inclusion: { in: %w[like dislike] }
end
