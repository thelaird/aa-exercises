# == Schema Information
#
# Table name: subs
#
#  id           :integer          not null, primary key
#  moderator_id :integer          not null
#  title        :string           not null
#  description  :text
#  created_at   :datetime
#  updated_at   :datetime
#

class Sub < ActiveRecord::Base
  validates :moderator_id, :title, presence: true
  belongs_to(
    :moderator,
    class_name: 'User',
    foreign_key: :moderator_id
    )
  has_many :post_subs
  has_many :posts, through: :post_subs, source: :post
end
