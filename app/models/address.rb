# frozen_string_literal: true

class Address < ApplicationRecord
  belongs_to :municipe

  validates :zipcode, :street, :district, :city, :state, presence: true
  validates_correios_cep_of :zipcode
end
