# frozen_string_literal: true

class UploadsController < ApplicationController
  MAX_FILE_SIZE = 5.megabytes
  ACCEPTED_TYPES = %w[text/plain].freeze

  def create
    result = FileService.new(params[:file]).process
    result[:success] ? handle_success(result) : handle_failure(result)
  end

  private

  def handle_success(result)
    @customers = Customer.includes(:vehicle).order(:last_name)
    respond_to do |format|
      format.html do
        flash[:success] = result[:message]
        redirect_to customers_path
      end
    end
  end

  def handle_failure(result)
    respond_to do |format|
      format.html do
        flash[:error] = format_error_message(result)
        redirect_to customers_path
      end
    end
  end

  def format_error_message(result)
    message = result[:message]
    if result[:details].present?
      result[:details].each do |detail|
        message += "<li class='alert-details-text'>#{detail}</li>"
      end
      message += '</ul>'
    end
    message
  end
end
