# frozen_string_literal: true

require_relative "../lib/input_reader"
require_relative "../lib/company_data_exporter"

module Challenge
  def run
    users_json = File.join(__dir__, "../data/users.json")
    companies_json = File.join(__dir__, "../data/companies.json")
    output_txt = File.join(__dir__, "../output/output.txt")

    users = InputReader.read_users_data(users_json)
    companies = InputReader.read_companies_data(companies_json)

    companies = CompanyDataExporter.assign_users_to_company(users, companies)
    companies = CompanyDataExporter.top_up_active_users(companies)
    companies = CompanyDataExporter.filter_and_sort_companies(companies)

    CompanyDataExporter.export(output_txt, companies)
  end

  module_function :run
end

Challenge.run
