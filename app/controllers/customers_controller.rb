# frozen_string_literal: true

class CustomersController < ApplicationController
  include SortHelper

  def index
    @sort_column = params[:sort] || 'first_name'
    @sort_direction = params[:direction] || 'asc'
    @customers = formatted_customer_data
    respond_to(&:html)
  end

  private

  def formatted_customer_data
    Customer.includes(:vehicle).order("#{@sort_column} #{@sort_direction}").map do |customer|
      {
        full_name: customer.full_name,
        email: customer.email,
        vehicle_type: customer.vehicle.formatted_vehicle_type,
        vehicle_name: customer.vehicle.name,
        vehicle_length: "#{customer.vehicle.length} ft."
      }
    end
  end
end
