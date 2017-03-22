class User < ActiveRecord::Base
  has_secure_password
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :first_name, :last_name, :city, :state, presence: true, length: {minimum:2}
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
  has_many :events, :dependent => :destroy
  has_many :attendees, :dependent => :destroy
  has_many :attending, class_name: 'Event', through: :attendees, source: "event"
end
