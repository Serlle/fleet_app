module Api
  module V1
    class MaintenanceServicesController < BaseController
      before_action :set_vehicle, only: %i[index create]
      before_action :set_maintenance_service, only: %i[show update destroy]

      # GET /api/v1/vehicles/:vehicle_id/maintenance_services
      def index
        services = @vehicle.maintenance_services.page(params[:page]).per(params[:per_page] || 5).order(created_at: :desc)
        render json: services, each_serializer: MaintenanceServiceSerializer, meta: pagination_meta(services)
      end

      # POST /api/v1/vehicles/:vehicle_id/maintenance_services
      def create
        ms = @vehicle.maintenance_services.build(maintenance_service_params)
        if ms.save
          render json: ms, status: :created
        else
          render_error(code: 'validation_error', message: 'Invalid attributes', details: ms.errors.full_messages)
        end
      end

      # GET /api/v1/maintenance_services/:id
      def show
        render json: @maintenance_service
      end

      # PUT/PATCH /api/v1/maintenance_services/:id
      def update
        if @maintenance_service.update(maintenance_service_params)
          render json: @maintenance_service
        else
          render_error(code: 'validation_error', message: 'Invalid attributes', details: @maintenance_service.errors.full_messages)
        end
      end

      # DELETE /api/v1/maintenance_services/:id
      def destroy
        @maintenance_service.destroy!
        head :no_content
      end

      private

      def set_vehicle
        @vehicle = Vehicle.find(params[:vehicle_id])
      end

      def set_maintenance_service
        @maintenance_service = MaintenanceService.find(params[:id])
      end

      def maintenance_service_params
        params.require(:maintenance_service).permit(:description, :status, :date, :cost_cents, :priority, :completed_at)
      end
    end
  end
end
