class Like < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :post

  validates :author, presence: true
  validates :post, presence: true

  def update_likes_counter(_post_id)
    post.increment!(:likes_counter)
  end
end
