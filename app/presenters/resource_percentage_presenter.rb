# frozen_string_literal: true

class ResourcePercentagePresenter
  def generate_resource_percentage_report
    ships = Ship.all
    pilots_ids = ships.pluck(:pilot_id)
    pilots = Pilot.where(id: pilots_ids)

    # Pq não funciona usando Pilot.where.not(ship: nil)?

    report_data = {}

    pilots.each do |pilot|
      resource_percentages = calculate_resource_percentage(pilot)
      next if resource_percentages.empty?

      report_data[pilot.name] = resource_percentages
    end

    report_data
  end

  private

  def calculate_resource_percentage(pilot)
    total_resource_weight = pilot.ship.contracts.finished.map { |c| c.resources.pluck(:weight).sum }.sum

    resource_percentages = {}
    pilot.ship.contracts.each do |contract|
      contract.resources.each do |resource|
        resource_percentages[resource.name] = 0
        resource_percentages[resource.name] += ((resource.weight / total_resource_weight) * 100).round(1)
      end
    end

    resource_percentages
  end
end
