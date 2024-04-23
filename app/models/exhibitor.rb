class Exhibitor < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence:true

  def self.ransackable_attributes(auth_object = nil)
    %w[name email discord_name]
  end

  def regenerate_password
    init_password = SecureRandom.hex(8)
    self.password = init_password
    self.password_confirmation = init_password
    self.save!
    init_password
  end
end
