# frozen_string_literal: true

module LengthParser
  def self.parse(length)
    return nil if length.blank?

    input = length.to_s.strip.downcase
    input = input.gsub(/feet|ft|ft\./, '').strip
    input = input.chomp("'")
    feet = input.to_i

    feet.positive? ? feet : nil
  end
end
