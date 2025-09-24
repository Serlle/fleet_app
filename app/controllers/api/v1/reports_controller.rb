module Api
  module V1
    class ReportsController < BaseController
      # skipe_before_action :ensure_api_format, only: [:maintenance_summary]
      # GET /api/v1/reports/maintenance_summary?from=YYYY-MM-DD&to=YYYY-MM-DD
      def maintenance_summary
        maintenance_services_between_dates = MaintenanceService.all
        
        if params[:from].present? && params[:to].present?
          unless valid_date_format?(params[:from], params[:to])
            return render_error(
              code: 'invalid_date_format',
              message: 'Dates must be in YYYY-MM-DD format',
              status: :bad_request
            )
          end

          from, to = parse_range(params[:from], params[:to])
          maintenance_services_between_dates = MaintenanceService.where(date: from..to)
        end

        total_orders = maintenance_services_between_dates.count
        total_cost_cents = maintenance_services_between_dates.sum(:cost_cents)
        desglose_by_status = maintenance_services_between_dates.group(:status).sum(:cost_cents)
        desglose_by_vehicle = maintenance_services_between_dates.includes(:vehicle).references(:vehicle).group(:plate).sum(:cost_cents)
        top3_vehicles_by_cost_cents = maintenance_services_between_dates.includes(:vehicle).references(:vehicle).group(:plate).sum(:cost_cents).sort_by { |_, cents| -cents }.first(3)

        respond_to do |format|
          format.json do
            render json: { 
              total_orders: total_orders, 
              total_cost_cents: total_cost_cents, 
              desglose_by_status: desglose_by_status,
              desglose_by_vehicle: desglose_by_vehicle,
              top3_vehicles_by_cost_cents: top3_vehicles_by_cost_cents
            }
          end

          format.csv do
            csv = ReportGenerator.to_csv(
              total_orders: total_orders,
              total_cost_cents: total_cost_cents,
              desglose_by_status: desglose_by_status,
              desglose_by_vehicle: desglose_by_vehicle,
              top3_vehicles_by_cost_cents: top3_vehicles_by_cost_cents,
              from: from,
              to: to
            )
            send_data csv,
                    filename: "maintenance_summary_#{from}_to_#{to}.csv",
                    type: 'text/csv',
                    disposition: 'attachment'
          end
        end
      end

      private 

      def parse_range(from_param, to_param)
        from = Date.parse(from_param) rescue Date.today.beginning_of_month #if the date is invalid, use the start of the current month
        to = Date.parse(to_param) rescue Date.today
        [from, to]
      end

      def valid_date_format?(from_param, to_param)
        from_param =~ /^\d{4}-\d{2}-\d{2}$/ && to_param =~ /^\d{4}-\d{2}-\d{2}$/
      end
    end
  end
end
