# frozen_string_literal: true

class Municipe < ApplicationRecord
  validates :name, :cpf, :cns, :email, :birth_date, :phone, :photo, :status,
            presence: true
  validates :cpf, :cns, :email, uniqueness: true
  validates_cpf_format_of :cpf
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validate :validate_birth_date
  validate :validate_cns

  mount_uploader :photo, PhotoUploader

  private

  def validate_cns
    return if ((0...15).sum { |i| cns[i].to_i * (15 - i) } % 11).zero?

    errors.add(:cns, 'is not a valid CNS')
  end

  def validate_birth_date
    errors.add(:birth_date, 'it cannot be in the future') if birth_date > Time.now
  end
end
