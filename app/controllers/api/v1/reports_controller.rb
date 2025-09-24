module Api
  module V1
    class ReportsController < BaseController
      before_action :params_present?, :check_params, only: [:maintenance_summary]
      # GET /api/v1/reports/maintenance_summary?from=YYYY-MM-DD&to=YYYY-MM-DD
      def maintenance_summary
        from, to = parse_range(params[:from], params[:to])
        result = Reports::MaintenanceSummary.call(from: from, to: to)

        respond_to do |format|
          format.json do
            render json: {
              total_orders: result.total_orders,
              total_cost_cents: result.total_cost_cents,
              breakdown_by_status: result.breakdown_by_status,
              breakdown_by_vehicle: result.breakdown_by_vehicle,
              top3_vehicles_by_cost_cents: result.top3_vehicles_by_cost_cents,
              from: result.from, to: result.to
            }
          end

          format.csv do
            csv = Reports::Generator.to_csv(
              total_orders: result.total_orders,
              total_cost_cents: result.total_cost_cents,
              breakdown_by_status: result.breakdown_by_status,
              breakdown_by_vehicle: result.breakdown_by_vehicle,
              top3_vehicles_by_cost_cents: result.top3_vehicles_by_cost_cents,
              from: result.from, to: result.to
            )
            send_data csv,
              filename: "maintenance_summary_#{result.from}_to_#{result.to}.csv",
              type: 'text/csv',
              disposition: 'attachment'
          end
        end
      end

      private

      def parse_range(from_param, to_param)
        from = Date.parse(from_param.to_s) rescue Date.today.beginning_of_month #if the date is invalid, we use the start of the current month
        to = Date.parse(to_param.to_s)   rescue Date.today
        [from, to]
      end

      def valid_date_format?(from_param, to_param)
        from_param =~ /^\d{4}-\d{2}-\d{2}$/ && to_param =~ /^\d{4}-\d{2}-\d{2}$/
      end

      def params_present?
        # validate format first
        return render_error(
          code: 'missing_dates', 
          message: 'Both from and to dates are required', 
          status: :bad_request
        ) if params[:from].blank? || params[:to].blank?
      end

      def check_params
        unless valid_date_format?(params[:from], params[:to])
          return render_error(
            code: 'invalid_date_format',
            message: 'Dates must be in YYYY-MM-DD format',
            status: :bad_request
          )
        end
      end
    end
  end
end
