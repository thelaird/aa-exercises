class Tagging < ActiveRecord::Base

  belongs_to(
    :tag,
    class_name: 'TagTopic',
    foreign_key: :tag_id,
    primary_key: :id
  )

  belongs_to(
    :short_url,
    class_name: 'ShortenedUrl',
    foreign_key: :short_url,
    primary_key: :short_url
  )

  def self.add_tag_url!(tag, url, user)
    Tagging.create!(tag_id: tag.id, short_url: url, user_id: user.id)
  end
end
