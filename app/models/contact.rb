# == Schema Information
#
# Table name: contacts
#
#  id               :integer          not null, primary key
#  label            :string(255)
#  type             :string(255)
#  contactable_id   :integer
#  contactable_type :string(255)
#  address          :string(255)
#  uuid             :string(255)      not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Contact < ActiveRecord::Base
  include Identifiable
  include ActiveModel::ForbiddenAttributesProtection

  RESPONSE_MAP = {
    :acknowledge => 4,
    :resolve => 6,
    :escalate => 8
  }

  belongs_to :contactable, polymorphic: true
  has_many :notification_rules

  validates :type, presence: true
  validates :label, presence: true
  validates :address, presence: true

  def response_options
    RESPONSE_MAP.map{|k,v| "#{k}: #{v}"}.join(', ')
  end
end
