# frozen_string_literal: true

class ResourceWeightsPresenter
  def generate_resource_weights_report
    contracts = Contract.where(status: 'finished')
    report_data = {}

    contracts.each do |contract|
      from_planet = contract.from_planet
      to_planet = contract.to_planet

      report_data[from_planet] = { sent: {}, received: {} }
      report_data[to_planet] = { sent: {}, received: {} }

      contract.resources.each do |resource|
        add_resource_weight(report_data[from_planet][:sent], resource)
        add_resource_weight(report_data[to_planet][:received], resource)
      end

    end

    report_data
  end

  private

  def add_resource_weight(resource_weights, resource)
    resource_weights[resource.name] ||= 0
    resource_weights[resource.name] += resource.weight
  end
end
