class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :post, counter_cache: true

  validates :text, presence: true
  after_save :update_post_comments_counter

  private

  def update_post_comments_counter(_comment)
    post.increment!(:comments_counter)
  end
end
