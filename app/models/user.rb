class User < ApplicationRecord
  has_many :posts
  has_many :comments
  has_many :likes

  validates :name, presence: true
  validates :posts_counter, numericality: { greater_than_or_equal_to: 0, only_integer: true }


  def recent_posts(num = 3)
    posts.order(created_at: :desc).limit(num)
  end
  
end
