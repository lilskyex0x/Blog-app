class User < ApplicationRecord
  has_many :posts

  has_many :comment, foreign_key: 'author_id'
  has_many :like, foreign_key: 'author_id'

  def three_recent_posts
    Post.where(author: self).order(created_at: :desc).first(3)
  end
end
