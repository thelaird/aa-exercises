class ShortenedUrl <ActiveRecord::Base
  validates :short_url, presence: true, uniqueness: true
  validates :long_url, length: { max = 1024,
    too_long: "%{count} characters is the max allowed" }
  validate :rate_limit

  def rate_limit
    user = User.find_by_id(:submitter_id)
    return true if user.submitted_urls.where( 'updated_at > ?', 1.minute.ago).count <= 5
    false
  end

  belongs_to(
   :submitter,
   class_name: 'User',
   foreign_key: :submitter_id,
   primary_key: :id
  )

  has_many(
   :visits,
   class_name: 'Visit',
   foreign_key: :short_url,
   primary_key: :short_url
  )

  has_many(
   :visitors,
   Proc.new { distinct },
   through: :visits,
   source: :visitor
  )

  has_many(
    :taggings,
    class_name: 'Tagging',
    foreign_key: :short_url,
    primary_key: :short_url
  )

  has_many(
    :tags,
    through: :taggings,
    source: :tag
  )

  def self.random_code
    valid_code = false
    until valid_code
      url = SecureRandom.urlsafe_base64.chars.take(16).join
      valid_code = !ShortenedUrl.exists?(:short_url => url)
    end

    url
  end

  def self.create_for_user_and_long_url!(user, long_url)
    ShortenedUrl.create!(submitter_id: user.id, long_url: long_url,
                         short_url: ShortenedUrl.random_code)
  end

  def num_clicks
    visits.count
  end

  def num_uniques
    visitors.count
  end

  def num_recent_uniques
    num_uniques.where('updated_at > ?', 10.minutes.ago)
  end
end
