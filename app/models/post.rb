class Post < ApplicationRecord
  belongs_to :user

  validates :content, presence: true, length: { maximum: 255 }

  # いいね機能
  has_many :favorites, dependent: :destroy

  # コメント機能
  has_many :comments, dependent: :destroy
end
