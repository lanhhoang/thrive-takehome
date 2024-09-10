# frozen_string_literal: true

require_relative "../parsable"

class Company
  include Parsable

  attr_reader :id, :name, :top_up, :email_status
  attr_accessor :users

  def initialize(id, name, top_up, email_status)
    @id = id
    @name = name
    @top_up = parse_int(top_up)
    @email_status = email_status
    @users = []
  end

  def email_enabled?
    email_status
  end

  def empty?
    users.empty?
  end

  def add_user(user)
    users << user
  end

  # sort users by first name and then by last name
  # to ensure alphabetical order is maintained
  # in the case of users with the same last name
  def sort_users(users_arr)
    users_arr.sort_by(&:first_name).sort_by(&:last_name)
  end

  def active_users
    sort_users(users).select(&:active?)
  end

  def emailed_users
    return [] unless email_enabled?

    active_users.select(&:email_enabled?)
  end

  def not_emailed_users
    return active_users unless email_enabled?

    active_users.reject(&:email_enabled?)
  end

  def total_top_up
    top_up * active_users.size
  end

  def to_s
    "\n\tCompany Id: #{id}" \
      "\n\tCompany Name: #{name}" \
      "\n\tUsers Emailed:" \
      "#{users_to_s(emailed_users)}" \
      "\n\tUsers Not Emailed:" \
      "#{users_to_s(not_emailed_users)}" \
      "\n\t\tTotal amount of top ups for #{name}: #{total_top_up}"
  end

  private

  def users_to_s(users_arr)
    users_arr.empty? ? "" : "\n#{users_arr.join("\n")}"
  end
end
