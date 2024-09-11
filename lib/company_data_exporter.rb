# frozen_string_literal: true

module CompanyDataExporter
  module_function

  def assign_users_to_company(users, companies)
    companies.map do |company|
      company.users = users.select { |user| user.company_id == company.id }
      company
    end
  end

  def top_up_active_users(companies)
    companies.each do |company|
      active_users = company.active_users
      active_users.each do |user|
        user.top_up(company.top_up)
      end
    end
  end

  def filter_and_sort_companies(companies)
    companies.reject(&:empty?).sort_by(&:id)
  end

  def export(to_file, items)
    File.open(to_file, "w") do |file|
      file.puts items
    end
  rescue StandardError => e
    puts "[ERROR]: Error while exporting data: #{e}"
  end
end
