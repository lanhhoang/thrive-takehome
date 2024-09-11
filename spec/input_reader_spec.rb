# frozen_string_literal: true

require_relative "../lib/input_reader"

describe InputReader do
  describe ".read_users_data" do
    context "when the input data is valid" do
      it "returns an array of User objects" do
        expect(described_class.read_users_data("spec/fixtures/valid_users.json")).to all(be_a(User))
      end
    end

    context "when the input data is invalid" do
      it "returns an empty array" do
        expect(described_class.read_users_data("spec/fixtures/invalid_users.json")).to be_empty
      end
    end
  end

  describe ".read_companies_data" do
    context "when the input data is valid" do
      it "returns an array of Company objects" do
        expect(described_class.read_companies_data("spec/fixtures/valid_companies.json")).to all(be_a(Company))
      end
    end

    context "when the input data is invalid" do
      it "returns an empty array" do
        expect(described_class.read_companies_data("spec/fixtures/invalid_companies.json")).to be_empty
      end
    end
  end

  describe ".import_json" do
    context "when the file exists" do
      it "returns an array of JSON objects" do
        expect(described_class.import_json("spec/fixtures/valid_users.json")).to all(be_a(Hash))
        expect(described_class.import_json("spec/fixtures/valid_companies.json")).to all(be_a(Hash))
      end
    end

    context "when the file does not exist" do
      it "returns nil" do
        expect(described_class.import_json("spec/fixtures/non_existent.json")).to be nil
      end
    end
  end

  describe ".parse_int" do
    context "when the value is a valid integer" do
      it "returns an Integer" do
        expect(described_class.parse_int("1")).to eq(1)
      end
    end

    context "when the value is not a valid integer" do
      it "returns nil" do
        expect(described_class.parse_int("invalid")).to be nil
      end
    end

    context "when the value is nil" do
      it "returns nil" do
        expect(described_class.parse_int(nil)).to be nil
      end
    end
  end
end
