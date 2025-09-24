# app/services/report_generator.rb
require "csv"

module Reports
  class Generator
    def self.to_csv(args = {})
      CSV.generate(headers: true) do |csv|
        if args[:from] && args[:to]
          csv << ["Maintenance Summary", "#{args[:from]} to #{args[:to]}"]
        else
          csv << ["Maintenance Summary", "All dates"]
        end
        csv << []

        csv << ["Total orders", args[:total_orders]]
        csv << ["Total cost (cents)", args[:total_cost_cents]]
        csv << []

        csv << ["Breakdown by status", "Cost (cents)"]
        (args[:breakdown_by_status] || {}).each { |status, cents| csv << [status, cents] }
        csv << []

        csv << ["Breakdown by vehicle (plate)", "Cost (cents)"]
        (args[:breakdown_by_vehicle] || {}).each { |plate, cents| csv << [plate, cents] }
        csv << []

        csv << ["Top 3 vehicles by cost", "Cost (cents)"]
        (args[:top3_vehicles_by_cost_cents] || []).each { |(plate, cents)| csv << [plate, cents] }
      end
    end
  end
end