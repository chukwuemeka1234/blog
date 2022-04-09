class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments_count
  has_many :likes_count

  def update_posts_count
    author.update(Posts_counter: author.post.count)
  end

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end
