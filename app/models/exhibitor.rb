class Exhibitor < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Exhibitor作成時には場所が未決定の場合があるので、optional: true とする
  belongs_to :place_block_master, optional: true

  has_many :exhibit_submissions, dependent: :destroy

  validates :name, presence:true
  validates :circle_name, presence:true
end
