require "./spec_helper"

describe Burocracia::CPF do
  describe "#valid?" do
    context "when all the chars are equal" do
      it "returns false" do
        Burocracia::CPF.valid?("1"*11).should be_false
      end
    end

    context "when there's more than 11 chars" do
      it "returns false" do
        Burocracia::CPF.valid?("123456789111").should be_false
      end
    end

    context "when there's less than 11 chars" do
      it "returns false" do
        Burocracia::CPF.valid?("1234").should be_false
      end
    end

    context "when the input is blacklisted" do
      it "returns false" do
        cpf = Burocracia::CPF::BLACKLIST.sample
        Burocracia::CPF.valid?(cpf).should be_false
      end

      it "returns false" do
        cpf = Burocracia::CPF.format(Burocracia::CPF::BLACKLIST.sample)
        Burocracia::CPF.valid?(cpf).should be_false
      end
    end

    context "when the input is valid" do
      it "returns true" do
        valids = ["05584857076", "182.184.250-20", "623.187.230-01", "79185535001"]
        Burocracia::CPF.valid?(valids.sample).should be_true
      end
    end

    context "when the input is invalid" do
      it "returns false" do
        valids = ["05584857071", "182.184.250-21", "623.187.230-41", "79185535032"]
        Burocracia::CPF.valid?(valids.sample).should be_false
      end
    end
  end

  describe "#formatted?" do
    context "when the input is formatted" do
      it "returns true" do
        Burocracia::CPF.formatted?("219.804.299-27").should be_true
      end
    end

    context "when the input is formatted" do
      it "returns false" do
        Burocracia::CPF.formatted?("21980429927").should be_false
      end
    end
  end

  describe "#format" do
    it "returns the formatted CPF" do
      Burocracia::CPF.format("21980429927").should eq("219.804.299-27")
    end

    context "when the CPF is already formatted" do
      it "returns the formatted CPF" do
        Burocracia::CPF.format("342.260.930-03").should eq("342.260.930-03")
      end
    end
  end

  describe "#generate" do
    context "when the format parameter is true" do
      it "generates a valid CPF" do
        generated = Burocracia::CPF.generate(format: true)
        Burocracia::CPF.valid?(generated).should be_true
      end

      it "generates a formatted CPF" do
        generated = Burocracia::CPF.generate(format: true)
        Burocracia::CPF.formatted?(generated).should be_true
      end
    end

    context "when the format parameter is false" do
      it "generates a valid CPF" do
        generated = Burocracia::CPF.generate
        Burocracia::CPF.valid?(generated).should be_true
      end

      it "generates a unformatted CPF" do
        generated = Burocracia::CPF.generate
        Burocracia::CPF.formatted?(generated).should be_false
      end
    end
  end

  describe "#sanitize" do
    it "clears the cpf" do
      Burocracia::CPF.sanitize("108.804.239-27").should eq("10880423927")
    end
  end
end
