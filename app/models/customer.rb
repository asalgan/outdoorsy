# frozen_string_literal: true

# == Schema Information
#
# Table name: customers
#
#  id         :bigint           not null, primary key
#  first_name :string
#  last_name  :string
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Customer < ActiveRecord::Base
  has_one :vehicle

  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name,  presence: true, length: { maximum: 50 }
  validates :email,      presence: true,
                         length: { maximum: 255 },
                         format: { with: URI::MailTo::EMAIL_REGEXP },
                         uniqueness: { case_sensitive: false }

  def full_name
    "#{first_name} #{last_name}"
  end
end
