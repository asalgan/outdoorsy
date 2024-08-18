# frozen_string_literal: true

class FileValidatorService
  MAX_FILE_SIZE = 5.megabytes
  ACCEPTED_TYPES = %w[text/plain].freeze

  def initialize(file)
    @file = file
  end

  def validate
    return { success: false, error: 'No file uploaded' } if @file.nil?
    return { success: false, error: 'Invalid file type. Please upload only TXT files.' } unless valid_file_type?
    return { success: false, error: 'File is too large. Maximum size is 5MB.' } unless valid_file_size?

    { success: true }
  end

  private

  def valid_file_type?
    ACCEPTED_TYPES.include?(@file.content_type)
  end

  def valid_file_size?
    @file.size <= MAX_FILE_SIZE
  end
end
