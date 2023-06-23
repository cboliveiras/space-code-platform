# frozen_string_literal: true

module V1
  class ShipsController < ApplicationController
    def index
      @ship = Ship.find_by(pilot_id: params[:pilot_id])

      render json: @ship, status: :ok
    end

    def create
      @pilot = Pilot.find_by(id: params[:pilot_id])

      return render json: { error: 'Pilot not found' }, status: :not_found unless @pilot

      @ship = Ship.new(ship_params)

      if @ship.save
        render json: @ship, status: :created
      else
        render json: @ship.errors, status: :unprocessable_entity
      end
    end

    private

    def ship_params
      params.require(:ship).permit(:fuel_capacity, :fuel_level, :weight_capacity, :pilot_id)
    end
  end
end
