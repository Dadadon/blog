class Comment < ApplicationRecord
  belongs_to :author, class_name: "User", foreign_key: "author_id"
  belongs_to :post, counter_cache: true

  def self.update_post_comments_counter(comment)
    post = comment.post
    post.update(comments_count: post.comments.count)
  end
end
