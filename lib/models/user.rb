# frozen_string_literal: true

require_relative "../parsable"

class User
  include Parsable

  attr_reader :id, :first_name, :last_name, :email, :company_id, :active_status, :email_status
  attr_accessor :previous_tokens, :tokens

  def initialize(id, first_name, last_name, email, company_id, active_status, email_status, tokens)
    @id = id
    @first_name = first_name
    @last_name = last_name
    @email = email
    @company_id = company_id
    @active_status = active_status
    @email_status = email_status
    @previous_tokens = 0
    @tokens = parse_int(tokens)
  end

  def active?
    active_status
  end

  def email_enabled?
    email_status
  end

  def top_up(amount)
    self.previous_tokens = tokens
    self.tokens += amount
  end

  def to_s
    "\t\t#{last_name}, #{first_name}, #{email}" \
      "\n\t\t\tPrevious Token Balance, #{previous_tokens}" \
      "\n\t\t\tNew Token Balance #{tokens}"
  end
end
