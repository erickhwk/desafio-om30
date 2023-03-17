# frozen_string_literal: true

class Municipe < ApplicationRecord
  has_one :address
  accepts_nested_attributes_for :address

  validates :name, :cpf, :cns, :email, :birth_date, :phone, :photo, :status,
            presence: true
  validates :cpf, :cns, :email, uniqueness: true
  validates_cpf_format_of :cpf
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  PHONE_REGEX = /\A(?:\+?\d{1,3}\s*-?)?\(?(?:\d{3})?\)?[- ]?\d{3}[- ]?\d{4}\z/

  validates :phone, format: { with: PHONE_REGEX }, length: { is: 13 }
  validate :validate_birth_date
  validate :validate_cns

  mount_uploader :photo, PhotoUploader

  private

  def validate_cns
    return if ((0...15).sum { |i| cns[i].to_i * (15 - i) } % 11).zero?

    errors.add(:cns, 'is not a valid CNS')
  end

  def validate_birth_date
    return if birth_date.nil?

    errors.add(:birth_date, 'it cannot be in the future') if birth_date > Time.now
  end

  def self.ransackable_associations(auth_object = nil)
    ["address"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["birth_date", "cns", "cpf", "created_at", "email", "id", "name", "phone", "photo", "status", "updated_at"]
  end
end
