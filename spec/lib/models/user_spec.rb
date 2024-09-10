# frozen_string_literal: true

require_relative "../../../lib/models/user"

describe User do
  describe "#initialize" do
    it "should create a new user" do
      user = User.new(*[1, "Tanya", "Nichols", "tanya.nichols@test.com", 1, true, true, 10])

      expect(user.id).to eq(1)
      expect(user.first_name).to eq("Tanya")
      expect(user.last_name).to eq("Nichols")
      expect(user.email).to eq("tanya.nichols@test.com")
      expect(user.company_id).to eq(1)
      expect(user.active_status).to be true
      expect(user.email_status).to be true
      expect(user.previous_tokens).to eq(0)
      expect(user.tokens).to eq(10)
    end

    it "should handle invalid tokens and set to 0" do
      user = User.new(*[1, "Tanya", "Nichols", "tanya.nichols@test.com", 1, true, true, "invalid"])

      expect(user.previous_tokens).to eq(0)
      expect(user.tokens).to eq(0)
    end
  end

  describe "#active?" do
    let(:user1) { User.new(1, "Tanya", "Nichols", "tanya.nichols@test.com", 1, true, true, 10) }
    let(:user2) { User.new(2, "Brent", "Rodriquez", "brent.rodriquez@test.com", 1, false, true, 10) }

    it "should be active if active_status is true" do
      expect(user1.active?).to be true
    end

    it "should not be active if active_status is false" do
      expect(user2.active?).to be false
    end
  end

  describe "#email_enabled?" do
    let(:user1) { User.new(1, "Tanya", "Nichols", "tanya.nichols@test.com", 1, true, true, 10) }
    let(:user2) { User.new(2, "Brent", "Rodriquez", "brent.rodriquez@test.com", 1, true, false, 0) }

    it "should be enabled if email_status is true" do
      expect(user1.email_enabled?).to be true
    end

    it "should not be enabled if email_status is false" do
      expect(user2.email_enabled?).to be false
    end
  end

  describe "#top_up" do
    let(:user1) { User.new(1, "Tanya", "Nichols", "tanya.nichols@test.com", 1, true, true, 10) }

    it "should increase the token balance" do
      user1.top_up(10)

      expect(user1.previous_tokens).to eq(10)
      expect(user1.tokens).to eq(20)
    end
  end

  describe "#to_s" do
    let(:user1) { User.new(1, "Tanya", "Nichols", "tanya.nichols@test.com", 1, true, true, 10) }
    let(:user1_string) do
      "\t\t#{user1.last_name}, #{user1.first_name}, #{user1.email}" \
      "\n\t\t\tPrevious Token Balance, #{user1.previous_tokens}" \
      "\n\t\t\tNew Token Balance #{user1.tokens}"
    end

    it "should return a string representation of the user" do
      expect(user1.to_s).to eq user1_string
    end
  end
end
