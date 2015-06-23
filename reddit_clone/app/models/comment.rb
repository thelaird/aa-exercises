class Comment < ActiveRecord::Base
  belongs_to :author, class_name: 'User'
  belongs_to :post
  validates :author_id, :post_id, :content, presence: true
  has_many(
    :child_comments,
    class_name: 'Comment',
    foreign_key: :parent_id,
    primary_key: :id
  )
end
