class TagTopic < ActiveRecord::Base
  validates :tag, presence: true, uniqueness: true

  has_many(
    :taggings,
    class_name: 'Tagging',
    foreign_key: :tag_id,
    primary_key: :id
  )

  has_many(
    :short_urls,
    through: :taggings,
    source: :short_url
  )

  def most_popular(n)
    max_visits = 0
    popular_url = nil
    urls = {}
    self.short_urls.each do |url|
      urls[url] = url.num_clicks
    end
    urls = urls.sort_by { |url, clicks| clicks }
    urls.reverse!.to_h.keys.take(n)
  end
end
