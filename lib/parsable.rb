# frozen_string_literal: true

module Parsable
  def parse_int(value)
    Integer(value)
  rescue ArgumentError => e
    puts "Error: #{e}. Setting to 0."
    0
  end
end
