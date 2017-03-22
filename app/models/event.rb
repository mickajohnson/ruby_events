class Event < ActiveRecord::Base
  belongs_to :user
  validates :name, :date, :city, :state, presence: true
  validate :date_cannot_be_in_the_past
  has_many :comments, :dependent => :destroy
  has_many :attendees, :dependent => :destroy
  has_many :users_attending, class_name: 'User', through: :attendees, source: "user"

  def date_cannot_be_in_the_past
    if date.present? && date < Date.today
      errors.add(:date, "can't be in the past")
    end
  end
end
