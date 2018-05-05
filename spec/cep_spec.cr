require "./spec_helper"

describe Burocracia::CEP do
  describe "#valid?" do
    context "when a invalid cep is passed" do
      it "returns false" do
        valid = Burocracia::CEP.valid? "802101301"
        valid.should be_false
      end

      it "returns false" do
        valid = Burocracia::CEP.valid? "00000000"
        valid.should be_false
      end

      it "returns false" do
        valid = Burocracia::CEP.valid? ""
        valid.should be_false
      end

      it "does not has side effects" do
        cep = "8a0b2c1d0e1f3g0"
        Burocracia::CEP.valid? cep
        cep.should eq "8a0b2c1d0e1f3g0"
      end
    end

    context "when a valid cep is passed" do
      valid = Burocracia::CEP.valid? "80210130"
      valid.should be_true
    end

    context "when a valid formatted cep is passed" do
      valid = Burocracia::CEP.valid? "80210-130"
      valid.should be_true
    end

    context "when the cep is blacklisted" do
      it "returns false" do
        cep = Burocracia::CEP::BLACKLIST.sample
        Burocracia::CEP.valid?(cep).should be_false
      end

      it "returns false" do
        cep = Burocracia::CEP.format(Burocracia::CEP::BLACKLIST.sample)
        Burocracia::CEP.valid?(cep).should be_false
      end
    end
  end

  describe "#formatted?" do
    context "when a formatted cep is passed" do
      it "returns true" do
        formatted = Burocracia::CEP.formatted? "80210-130"
        formatted.should be_true
      end
    end

    context "when a unformatted cep is passed" do
      it "returns true" do
        formatted = Burocracia::CEP.formatted? "80210130"
        formatted.should be_false
      end
    end
  end

  describe "#format" do
    it "formats the string" do
      formatted = Burocracia::CEP.format "80210130"
      is_formatted = Burocracia::CEP.formatted? formatted
      is_formatted.should be_true
    end

    context "when the input is formatted" do
      it "returns the same string" do
        formatted = Burocracia::CEP.format "80210-130"
        is_formatted = Burocracia::CEP.formatted? formatted
        is_formatted.should be_true
      end
    end
  end

  describe "#generate" do
    context "when the format argument is false" do
      it "does not format the generated cep" do
        generated = Burocracia::CEP.generate

        valid = Burocracia::CEP.valid? generated
        valid.should be_true

        formatted = Burocracia::CEP.formatted? generated
        formatted.should be_false
      end
    end

    context "when the format argument is true" do
      it "does not format the generated cep" do
        generated = Burocracia::CEP.generate(format: true)

        valid = Burocracia::CEP.valid? generated
        valid.should be_true

        formatted = Burocracia::CEP.formatted? generated
        formatted.should be_true
      end
    end
  end

  describe "#sanitize" do
    it "clears a formatted cep" do
      Burocracia::CEP.sanitize("80210-130").should eq("80210130")
    end
  end
end
