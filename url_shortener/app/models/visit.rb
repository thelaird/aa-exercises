class Visit < ActiveRecord::Base
  validates :visitor, :visited_url, presence: true

  belongs_to(
    :visitor,
    class_name: 'User',
    foreign_key: :user_id,
    primary_key: :id
  )

  belongs_to(
    :visited_url,
    class_name: 'ShortenedUrl',
    foreign_key: :short_url,
    primary_key: :short_url
  )

  def self.record_visit!(user, short_url)
    Visit.create!(user_id: user.id, short_url: short_url)
  end
end
