module Api
  module V1
    class VehiclesController < BaseController
      before_action :set_vehicle, only: %i[show update destroy]

      # GET /api/v1/vehicles
      def index
        vehicles = Vehicle.all
        render json: vehicles
      end

      # GET /api/v1/vehicles/:id
      def show
        render json: @vehicle
      end

      # POST /api/v1/vehicles
      def create
        vehicle = Vehicle.new(vehicle_params)
        if vehicle.save
          render json: vehicle, status: :created
        else
          render_error(code: 'validation_error', message: 'Invalid attributes', details: vehicle.errors.full_messages)
        end
      end

      # PUT/PATCH /api/v1/vehicles/:id
      def update
        if @vehicle.update(vehicle_params)
          render json: @vehicle
        else
          render_error(code: 'validation_error', message: 'Invalid attributes', details: @vehicle.errors.full_messages)
        end
      end

      # DELETE /api/v1/vehicles/:id
      def destroy
        @vehicle.destroy!
        head :no_content
      end

      private

      def set_vehicle
        @vehicle = Vehicle.find(params[:id])
      end

      def vehicle_params
        params.require(:vehicle).permit(:vin, :plate, :brand, :model, :year, :status)
      end
    end
  end
end
