# app/services/reports/maintenance_summary.rb
module Reports
  class MaintenanceSummary
    Result = Struct.new(
      :from, :to, :total_orders, :total_cost_cents,
      :breakdown_by_status, :breakdown_by_vehicle, :top3_vehicles_by_cost_cents,
      keyword_init: true
    )

    def self.call(from:, to:)
      scope = MaintenanceService.between_dates(from, to)

      Result.new(
        from: from,
        to: to,
        total_orders: scope.count,
        total_cost_cents: scope.sum(:cost_cents),
        breakdown_by_status: scope.sum_cost_by_status,
        breakdown_by_vehicle: scope.sum_cost_by_plate,
        top3_vehicles_by_cost_cents: MaintenanceService.top_vehicles_by_cost(from: from, to: to, limit: 3)
      )
    end
  end
end
