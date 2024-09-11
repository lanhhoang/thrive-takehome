# frozen_string_literal: true

require "json"

require_relative "models/user"
require_relative "models/company"

module InputReader
  module_function

  def read_users_data(from_file)
    import_json(from_file).map do |data|
      if parse_int(data["id"]).nil?
        puts "[ERROR]: User with email #{data['email']} has an invalid ID. Skip importing."
        next
      end

      if parse_int(data["tokens"]).nil?
        puts "[ERROR]: User with email #{data['email']} has an invalid tokens value. Skip importing."
        next
      end

      User.new(data["id"], data["first_name"], data["last_name"], data["email"], data["company_id"],
               data["active_status"], data["email_status"], data["tokens"])
    end.compact
  end

  def read_companies_data(from_file)
    import_json(from_file).map do |data|
      if parse_int(data["id"]).nil?
        puts "[ERROR]: Company #{data['name']} has an invalid ID. Skip importing."
        next
      end

      if parse_int(data["top_up"]).nil?
        puts "[ERROR]: Company #{data['name']} has an invalid top_up value. Skip importing."
        next
      end

      Company.new(data["id"], data["name"], data["top_up"], data["email_status"])
    end.compact
  end

  # Import JSON data from a file and handle possible exceptions like file not found or invalid input
  def import_json(from_file)
    JSON.parse(File.read(from_file))
  rescue Errno::ENOENT, JSON::ParserError => e
    puts "[ERROR]: #{e}"
    nil
  rescue StandardError => e
    puts "[ERROR]: Error while importing JSON file: #{e}"
    nil
  end

  def parse_int(value)
    Integer(value)
  rescue TypeError, ArgumentError => e
    puts "Error: #{e}. Setting to 0."
    nil
  end
end
