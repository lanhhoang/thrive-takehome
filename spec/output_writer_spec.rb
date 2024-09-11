# frozen_string_literal: true

require_relative "../lib/output_writer"
require_relative "../lib/models/user"
require_relative "../lib/models/company"

describe OutputWriter do
  describe ".assign_users_to_company" do
    let(:company) { Company.new(1, "Company A", 10, true) }
    let(:user1) { User.new(1, "Tanya", "Nichols", "tanya.nichols@test.com", 1, true, true, 10) }
    let(:user2) { User.new(2, "Brent", "Rodriquez", "brent.rodriquez@test.com", 1, false, true, 10) }
    let(:users) { [user1, user2] }
    let(:companies) { [company] }
    
    it "assigns users to the company" do
      expect(described_class.assign_users_to_company(users, companies).first.users).to eq(users)
    end
  end

  describe ".top_up_active_users" do
    let(:company) { Company.new(1, "Company A", 10, true) }
    let(:user1) { User.new(1, "Tanya", "Nichols", "tanya.nichols@test.com", 1, true, true, 10) }
    let(:user2) { User.new(2, "Brent", "Rodriquez", "brent.rodriquez@test.com", 1, false, true, 10) }

    it "tops up active users" do
      company.add_user(user1)
      company.add_user(user2)

      described_class.top_up_active_users([company])

      expect(user1.tokens).to eq(20)
      expect(user2.tokens).to eq(10)
    end
  end

  describe ".filter_and_sort_companies" do
    let(:company1) { Company.new(1, "Company A", 10, true) }
    let(:company2) { Company.new(2, "Company B", 20, false) }
    let(:user1) { User.new(1, "Tanya", "Nichols", "tanya.nichols@test.com", 1, true, true, 10) }
    let(:user2) { User.new(2, "Brent", "Rodriquez", "brent.rodriquez@test.com", 1, true, false, 10) }

    let(:companies) { [company1, company2] }

    it "filters and sorts companies" do
      company1.add_user(user1)
      company1.add_user(user2)

      expect(described_class.filter_and_sort_companies(companies)).to eq([company1])
    end
  end

  describe ".export" do
    let(:items) { ["item1", "item2"] }

    it "exports items to a file" do
      described_class.export("spec/fixtures/output.txt", items)

      expect(File.read("spec/fixtures/output.txt")).to eq("item1\nitem2\n")
    end

    it "raises an error if the file cannot be written" do
      allow(File).to receive(:open).and_raise(StandardError)

      expect { described_class.export("spec/fixtures/output.txt", items) }.to output("[ERROR]: Error while exporting data: StandardError\n").to_stdout
    end
  end
end
