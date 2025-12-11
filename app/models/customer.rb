class Customer < ApplicationRecord

  validates :tel, presence: true, unless: -> {tel.present?}
  validates :email, presence: true, unless: -> {email.present?}
  before_save :normalize_fields

  def normalize_fields
    self.email = email.downcase if email.present?
    self.name = name.strip.gsub(/\s+/, " ") if name.present?
    self.tel = tel.gsub(/\D/, "") if tel.present?
  end


end
