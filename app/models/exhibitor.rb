class Exhibitor < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :name, presence:true

  enum exhibitor_type: { working_adult: 0, student: 1 }

  has_many :exhibit_informations, dependent: :restrict_with_error

  def self.ransackable_attributes(auth_object = nil)
    %w[name email discord_name exhibitor_type]
  end

  def regenerate_password(send_mail: true)
    init_password = SecureRandom.hex(4)
    self.password = init_password
    self.password_confirmation = init_password
    self.save!
    ExhibitorMailer.regenerate_password_email(email, init_password).deliver_now if send_mail
    init_password
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[name email discord_name exhibitor_type]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end
