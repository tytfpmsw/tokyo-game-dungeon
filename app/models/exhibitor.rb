class Exhibitor < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :exhibit_submissions, dependent: :destroy
  has_many :exhibit_permissions

  validates :name, presence:true
  validates :circle_name, presence:true
end
