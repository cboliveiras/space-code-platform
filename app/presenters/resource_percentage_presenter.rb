# frozen_string_literal: true

class ResourcePercentagePresenter
  def generate_resource_percentage_report
    ships = Ship.all.includes(:contracts, :pilot)

    report_data = {}

    ships.each do |ship|
      pilot = ship.pilot
      resource_percentages = calculate_resource_percentage(ship)

      next if resource_percentages.empty?

      report_data[pilot.name] = resource_percentages
    end

    report_data
  end

  private

  def calculate_resource_percentage(ship)
    total_resource_weight = ship.contracts.finished.map { |c| c.resources.pluck(:weight).sum }.sum

    resource_percentages = {}
    ship.contracts.each do |contract|
      contract.resources.each do |resource|
        resource_percentages[resource.name] ||= 0
        resource_percentages[resource.name] += ((resource.weight / total_resource_weight) * 100).round(1)
      end
    end

    resource_percentages
  end
end
