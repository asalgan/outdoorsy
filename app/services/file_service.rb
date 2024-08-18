# frozen_string_literal: true

class FileService
  include LengthParser

  def initialize(file)
    @file = file
    @successful_count = 0
    @failed_count = 0
    @errors = []
  end

  def process
    validation_result = FileValidatorService.new(@file).validate
    return validation_result unless validation_result[:success]

    parse_file
    generate_result
  end

  private

  def parse_file
    @file.read.split(/\n/).each do |line|
      process_line(line)
    end
  end

  def process_line(line)
    fields = line.include?('|') ? line.split('|') : line.split(',')
    if fields.any?(&:blank?)
      add_error('Missing fields')
      nil
    else
      create_records(fields)
    end
  end

  def create_records(fields)
    first_name, last_name, email, vehicle_type, name, length = fields

    ActiveRecord::Base.transaction do
      customer = create_customer(first_name, last_name, email)
      create_vehicle(vehicle_type, name, length, customer.id)
      @successful_count += 1
    end
  rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotUnique => e
    add_error(e.message.to_s)
  end

  def create_customer(first_name, last_name, email)
    Customer.find_or_create_by!(first_name:, last_name:, email:)
  end

  def create_vehicle(vehicle_type, name, length, customer_id)
    Vehicle.find_or_create_by!(
      vehicle_type: Vehicle.vehicle_types[vehicle_type.downcase],
      length: LengthParser.parse(length),
      name:,
      customer_id:
    )
  end

  def generate_result
    if @failed_count.zero?
      { success: true, message: "Successfully imported #{@successful_count} records." }
    else
      {
        success: false,
        message: "Import failed. #{@failed_count} records failed to import:",
        details: @errors
      }
    end
  end

  def add_error(message)
    @failed_count += 1
    @errors << message.to_s
  end
end
