# frozen_string_literal: true

module V1
  class TravelsController < ApplicationController
    before_action :set_pilot, only: %i[index travel_between_planets register_fuel_refill]

    def index
      @travels = Travel.where(ship: @pilot.ship)

      render json: @travels, status: :ok
    end

    def travel_between_planets
      unless params[:to_planet]
        return render json: { error: 'Missing parameter: to_planet' },
                      status: :unprocessable_entity
      end

      service = TravelService.new(@pilot, params[:to_planet])

      if service.perform_travel
        render json: { message: 'Travel successful!' }, status: :ok
      else
        render json: { errors: service.errors }, status: :unprocessable_entity
      end
    end

    def register_fuel_refill
      service = FuelRefillService.new(@pilot, params[:to_planet])

      if service.refill?
        render json: { message: 'Fuel refill successful!' }, status: :ok
      else
        render json: { errors: service.errors }, status: :unprocessable_entity
      end
    end

    private

    def set_pilot
      @pilot = Pilot.find_by(id: params[:id])

      render json: { error: 'Pilot not found' }, status: :not_found unless @pilot
    end
  end
end
