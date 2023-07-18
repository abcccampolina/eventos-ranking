class User < ApplicationRecord
  belongs_to :organization, required: false

  has_and_belongs_to_many :eventos

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

  scope :tipo_juri, -> { where(tipo_usuario: 'Juri') }
  scope :sem_juris, -> { where.not(tipo_usuario: 'Juri') }

  after_create :send_created_mail
  def send_created_mail
    password = Devise.friendly_token(8)
    self.reset_password(password, password)

    raw, enc = Devise.token_generator.generate(self.class, :reset_password_token)
    self.reset_password_token = enc
    self.reset_password_sent_at = Time.now.utc
    self.save(validate: false)
    UserMailer.new_user(self, password, raw).deliver
  end
end
