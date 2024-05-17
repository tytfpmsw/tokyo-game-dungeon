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

  def regenerate_password
    init_password = SecureRandom.hex(4)
    self.password = init_password
    self.password_confirmation = init_password
    self.save!
    init_password
  end
end
