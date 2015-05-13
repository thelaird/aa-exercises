class User < ActiveRecord::Base
  validates :username, :password_digest, :session_token, presence: true
  validates :username, :session_token, uniqueness: true

  has_many :cats, dependent: :destroy

  after_initialize :ensure_session_token

  def self.find_by_credentials(username, password)
    user = self.find_by(username: username)
    user && user.is_password?(password) ? user : nil
  end

  def reset_session_token!
    new_token = SecureRandom::urlsafe_base64
    new_token if self.update(session_token: new_token)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  private

  def ensure_session_token
    self.session_token ||= SecureRandom::urlsafe_base64
  end
end
