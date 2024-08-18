# frozen_string_literal: true

# == Schema Information
#
# Table name: vehicles
#
#  id           :bigint           not null, primary key
#  customer_id  :bigint
#  vehicle_type :string
#  name         :string
#  length       :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Vehicle < ActiveRecord::Base
  include LengthParser

  belongs_to :customer

  validates :vehicle_type, presence: true
  validates :name, presence: true
  validates :length, presence: true # Length is always in feet, no partial feet.

  enum vehicle_type: %i[sailboat motorboat rv campervan bicycle]

  before_validation :parse_length

  def formatted_vehicle_type
    vehicle_type == 'rv' ? 'RV' : vehicle_type.capitalize
  end

  private

  def parse_length
    parsed_length = LengthParser.parse(length)
    if parsed_length
      self.length = parsed_length
    else
      errors.add(:length, 'invalid length format')
    end
  end
end
