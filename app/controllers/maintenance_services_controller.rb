class MaintenanceServicesController < ApplicationController
  before_action :set_vehicle, except: %i[show edit update destroy]
  before_action :set_maintenance_service, only: %i[ show edit update destroy ]

  # GET /maintenance_services or /maintenance_services.json
  def index
    @maintenance_services = @vehicle ? @vehicle.maintenance_services : MaintenanceService.all
    @maintenance_services = @maintenance_services.order(created_at: :desc).page(params[:page]).per(params[:per_page] || 5)

    respond_to do |format|
      format.html
      format.json { render json: @maintenance_services }
    end
  end

  # GET /maintenance_services/1 or /maintenance_services/1.json
  def show
  end

  # GET /maintenance_services/new
  def new
    @maintenance_service = MaintenanceService.new
  end

  # GET /maintenance_services/1/edit
  def edit
  end

  # POST /maintenance_services or /maintenance_services.json
  def create
    if @vehicle
      @maintenance_service = @vehicle.maintenance_services.build(maintenance_service_params)
    else
      @maintenance_service = MaintenanceService.new(maintenance_service_params)
    end

    respond_to do |format|
      if @maintenance_service.save
        # redirect to the nested maintenance_service show path
        format.html { redirect_to vehicle_maintenance_service_path(@vehicle, @maintenance_service), notice: "Maintenance service was successfully created." }
        format.json { render :show, status: :created, location: @maintenance_service }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @maintenance_service.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /maintenance_services/1 or /maintenance_services/1.json
  def update
    respond_to do |format|
      if @maintenance_service.update(maintenance_service_params)
        # redirect to the nested maintenance_service show path
        format.html { redirect_to vehicle_maintenance_service_path(@maintenance_service.vehicle, @maintenance_service), notice: "Maintenance service was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @maintenance_service }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @maintenance_service.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /maintenance_services/1 or /maintenance_services/1.json
  def destroy
    vehicle = @maintenance_service.vehicle
    @maintenance_service.destroy
    
    respond_to do |format|
      format.html { redirect_to vehicle_maintenance_services_path(vehicle), notice: "Maintenance service was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_maintenance_service
      @maintenance_service = MaintenanceService.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def maintenance_service_params
      params.require(:maintenance_service).permit(:description, :status, :date, :cost_cents, :priority, :completed_at)
    end

    def set_vehicle
      @vehicle = Vehicle.find(params[:vehicle_id]) if params[:vehicle_id].present?
    end
end
