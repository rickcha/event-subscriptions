class Event < ActiveRecord::Base
  has_and_belongs_to_many :users
  
  validates :title, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :province, presence: true
  validates :postalcode, presence: true
  validates :country, presence: true
  validates :event_type, presence: true
  
  # geocoder
  geocoded_by :full_address
  after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? }
  
  def full_address
    [address, city, province, postalcode, country].compact.join(",")
  end
end