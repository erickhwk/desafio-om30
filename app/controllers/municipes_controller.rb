# frozen_string_literal: true

class MunicipesController < ApplicationController
  before_action :set_municipe, only: %i[show edit update]

  def index
    @municipes = Municipe.all
  end

  def show; end

  def new
    @municipe = Municipe.new
    @municipe.build_address
  end

  def create
    @municipe = Municipe.new(municipe_params)
    if @municipe.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit; end

  def update
    @municipe.update(municipe_params)

    redirect_to root_path
  end

  private

  def set_municipe
    @municipe = Municipe.find(params[:id])
  end

  def municipe_params
    params.require(:municipe).permit(:name, :cpf, :cns, :email, :birth_date,
                                     :phone, :photo, :status,
                                     address_attributes: %i[id
                                                            zipcode
                                                            street
                                                            complement
                                                            district
                                                            city
                                                            state
                                                            ibge_code])
  end
end
