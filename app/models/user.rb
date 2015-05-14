class User < ActiveRecord::Base
  validates :username, :password_digest, presence: true
  validates :username, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }

  has_many :cats, dependent: :destroy
  has_many :requests, class_name: 'CatRentalRequest', dependent: :destroy
  has_many :sessions, dependent: :destroy

  attr_reader :password

  def self.find_by_session_token(session_token)
    all
      .joins(:sessions)
      .where("sessions.session_token = ?", session_token)
      .limit(1)[0]
  end

  def self.find_by_credentials(username, password)
    user = self.find_by(username: username)
    user && user.is_password?(password) ? user : nil
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end
end
