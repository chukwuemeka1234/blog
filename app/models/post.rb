class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  after_save :update_posts_counter
  validates :Title, presence: true, length: { maximum: 250 }
  validates :Comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :Likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def recent_comments
    comments.limit(5).order(created_at: :desc)
  end

  private

  def update_posts_counter
    author.increment!(:Posts_counter)
  end
end
