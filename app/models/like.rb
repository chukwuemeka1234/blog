class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post
  after_save :update_likes_counter

  private

  def update_likes_counter
    post.increment!(:Likes_counter)
  end
end
