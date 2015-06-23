# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  url        :string
#  content    :string
#  author_id  :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Post < ActiveRecord::Base
  validates :title, :author_id, presence: true
  validates :subs, presence: true

  belongs_to :author, class_name: "User"
  has_many :post_subs
  has_many :subs, through: :post_subs, source: :sub
  has_many :comments

end
