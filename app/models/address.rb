# frozen_string_literal: true

class Address < ApplicationRecord
  belongs_to :municipe

  validates :zipcode, :street, :district, :city, :state, presence: true
  validates_correios_cep_of :zipcode
  validate :validate_state

  STATES_ARRAY = %w[AC AL AP AM BA CE DF ES GO MA MS MT MG PA PB PR PE PI RJ RN RS RO RR SC SP SE TO].freeze
end
