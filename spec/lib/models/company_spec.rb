# frozen_string_literal: true

require_relative "../../../lib/models/company"
require_relative "../../../lib/models/user"

describe Company do
  describe "#initialize" do
    it "should create a new company" do
      company = Company.new(*[1, "Company A", 10, true])

      expect(company.id).to eq(1)
      expect(company.name).to eq("Company A")
      expect(company.top_up).to eq(10)
      expect(company.email_status).to be true
      expect(company.users).to eq([])
    end

    it "should handle invalid top_up and set to 0" do
      company = Company.new(*[1, "Company A", "invalid", true])

      expect(company.top_up).to eq(0)
    end
  end

  describe "#email_enabled?" do
    let(:company1) { Company.new(1, "Company A", 10, true) }
    let(:company2) { Company.new(2, "Company B", 20, false) }

    it "should be enabled if email_status is true" do
      expect(company1.email_enabled?).to be true
    end

    it "should not be enabled if email_status is false" do
      expect(company2.email_enabled?).to be false
    end
  end

  describe "#empty?" do
    let(:company) { Company.new(1, "Company A", 10, true) }
    let(:user1) { User.new(1, "Tanya", "Nichols", "tanya.nichols@test.com", 1, true, true, 10) }

    it "should return true if the company has no users" do
      expect(company.empty?).to be true
    end

    it "should return false if the company has users" do
      company.add_user(user1)

      expect(company.empty?).to be false
    end
  end

  describe "#add_user" do
    let(:company) { Company.new(1, "Company A", 10, true) }
    let(:user1) { User.new(1, "Tanya", "Nichols", "tanya.nichols@test.com", 1, true, true, 10) }
    let(:user2) { User.new(2, "Brent", "Rodriquez", "brent.rodriquez@test.com", 1, false, true, 10) }

    it "should add a user to the company" do
      company.add_user(user1)
      company.add_user(user2)

      expect(company.users.size).to eq(2)
      expect(company.users.first).to eq(user1)
      expect(company.users.last).to eq(user2)
    end
  end

  describe "#sort_users" do
    let(:company) { Company.new(1, "Company A", 10, true) }
    let(:user1) { User.new(1, "Tanya", "Nichols", "tanya.nichols@test.com", 1, true, true, 10) }
    let(:user2) { User.new(2, "Brent", "Rodriquez", "brent.rodriquez@test.com", 1, false, true, 10) }

    it "should return users sorted alphabetically by last name" do
      company.add_user(user1)
      company.add_user(user2)
      sorted_users = company.sort_users(company.users)

      expect(sorted_users.size).to eq(2)
      expect(sorted_users.first).to eq(user1)
      expect(sorted_users.last).to eq(user2)
    end
  end

  describe "#active_users" do
    let(:company) { Company.new(1, "Company A", 10, true) }
    let(:user1) { User.new(1, "Tanya", "Nichols", "tanya.nichols@test.com", 1, true, true, 10) }
    let(:user2) { User.new(2, "Brent", "Rodriquez", "brent.rodriquez@test.com", 1, false, true, 10) }

    it "should return active users" do
      company.add_user(user1)
      company.add_user(user2)

      expect(company.active_users.size).to eq(1)
      expect(company.active_users.first).to eq(user1)
    end
  end

  describe "#emailed_users" do
    let(:company1) { Company.new(1, "Company A", 10, true) }
    let(:user1) { User.new(1, "Tanya", "Nichols", "tanya.nichols@test.com", 1, true, true, 10) }
    let(:user2) { User.new(2, "Brent", "Rodriquez", "brent.rodriquez@test.com", 1, true, false, 10) }

    let(:company2) { Company.new(2, "Company B", 20, false) }
    let(:user3) { User.new(3, "Monica", "Castro", "monica.castro@notreal.com", 2, true, true, 10) }
    let(:user4) { User.new(4, "Bernard", "Wells", "bernard.wells@demo.com", 2, true, true, 10) }

    it "should return users that have been emailed if company email_status is true" do
      company1.add_user(user1)
      company1.add_user(user2)

      expect(company1.emailed_users.size).to eq(1)
      expect(company1.emailed_users.first).to eq(user1)
    end

    it "should return an empty array if company email_status is false" do
      company2.add_user(user3)
      company2.add_user(user4)

      expect(company2.emailed_users.size).to eq(0)
    end
  end

  describe "#not_emailed_users" do
    let(:company1) { Company.new(1, "Company A", 10, true) }
    let(:user1) { User.new(1, "Tanya", "Nichols", "tanya.nichols@test.com", 1, true, true, 10) }
    let(:user2) { User.new(2, "Brent", "Rodriquez", "brent.rodriquez@test.com", 1, true, false, 10) }

    let(:company2) { Company.new(2, "Company B", 20, false) }
    let(:user3) { User.new(3, "Monica", "Castro", "monica.castro@notreal.com", 2, true, true, 10) }
    let(:user4) { User.new(4, "Bernard", "Wells", "bernard.wells@demo.com", 2, true, true, 10) }

    it "should return users that have not been emailed if company email_status is true" do
      company1.add_user(user1)
      company1.add_user(user2)

      expect(company1.not_emailed_users.size).to eq(1)
      expect(company1.not_emailed_users.first).to eq(user2)
    end

    it "should return all active users if company email_status is false" do
      company2.add_user(user3)
      company2.add_user(user4)

      expect(company2.not_emailed_users.size).to eq(2)
      expect(company2.not_emailed_users.first).to eq(user3)
      expect(company2.not_emailed_users.last).to eq(user4)
    end
  end

  describe "#total_top_up" do
    let(:company) { Company.new(1, "Company A", 10, true) }
    let(:user1) { User.new(1, "Tanya", "Nichols", "tanya.nichols@test.com", 1, true, true, 10) }
    let(:user2) { User.new(2, "Brent", "Rodriquez", "brent.rodriquez@test.com", 1, false, true, 10) }

    it "should return the total amount of top ups for the company" do
      company.add_user(user1)
      company.add_user(user2)

      expect(company.total_top_up).to eq(10)
    end
  end

  describe "#to_s" do
    let(:company) { Company.new(1, "Company A", 10, true) }
    let(:user1) { User.new(1, "Tanya", "Nichols", "tanya.nichols@test.com", 1, true, true, 10) }
    let(:user2) { User.new(2, "Brent", "Rodriquez", "brent.rodriquez@test.com", 1, false, true, 10) }
    let(:company_string) do
      "\n\tCompany Id: #{company.id}" \
      "\n\tCompany Name: #{company.name}" \
      "\n\tUsers Emailed:" \
      "#{company.emailed_users.empty? ? "": "\n" + company.emailed_users.join("\n")}" \
      "\n\tUsers Not Emailed:" \
      "#{company.not_emailed_users.empty? ? "": "\n" + company.not_emailed_users.join("\n")}" \
      "\n\t\tTotal amount of top ups for #{company.name}: #{company.total_top_up}"
    end

    it "should return a string representation of the company" do
      company.add_user(user1)
      company.add_user(user2)

      expect(company.to_s).to eq(company_string)
    end
  end
    
    
end
