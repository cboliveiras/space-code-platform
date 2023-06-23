# frozen_string_literal: true

module V1
  class PilotsController < ApplicationController
    before_action :set_pilot, only: [:show, :grant_credits]

    def index
      @pilots = Pilot.all

      render json: @pilots, status: :ok
    end

    def show
      render json: @pilot, status: :ok
    end

    def create
      @pilot = Pilot.new(pilot_params)

      if @pilot.save
        render json: @pilot, status: :created
      else
        render json: @pilot.errors, status: :unprocessable_entity
      end
    end

    def grant_credits
      service = GrantCreditsService.new(@pilot, params[:travel_id], params[:contract_id])

      if service.grant_credits?
        render json: { message: 'Yes, you did it! Credits granted!' }, status: :ok
      else
        render json: { errors: service.errors }, status: :unprocessable_entity
      end
    end

    private

    def set_pilot
      @pilot = Pilot.find_by(id: params[:id])

      render json: { error: 'Pilot not found' }, status: :not_found unless @pilot
    end

    def pilot_params
      params.require(:pilot).permit(:name, :age, :certification, :credits, :location)
    end
  end
end
