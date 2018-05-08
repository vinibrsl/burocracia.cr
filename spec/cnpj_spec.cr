require "./spec_helper"

describe Burocracia::CNPJ do
  describe "#valid?" do
    context "when all the chars are equal" do
      it "returns false" do
        Burocracia::CNPJ.valid?("1"*14).should be_false
      end
    end

    context "when there's more than 14 chars" do
      it "returns false" do
        Burocracia::CNPJ.valid?("123456789111111").should be_false
      end
    end

    context "when there's less than 14 chars" do
      it "returns false" do
        Burocracia::CNPJ.valid?("1234").should be_false
      end
    end

    context "when the input is blacklisted" do
      it "returns false" do
        cpf = Burocracia::CNPJ::BLACKLIST.sample
        Burocracia::CNPJ.valid?(cpf).should be_false
      end

      it "returns false" do
        cpf = Burocracia::CNPJ.format(Burocracia::CNPJ::BLACKLIST.sample)
        Burocracia::CNPJ.valid?(cpf).should be_false
      end
    end

    context "when the input is valid" do
      it "returns true" do
        valids = ["84.182.697/0001-59", "70.666.463/0001-72", "98144683000155", "92938645000198"]
        Burocracia::CNPJ.valid?(valids.sample).should be_true
      end
    end

    context "when the input is invalid" do
      it "returns false" do
        invalids = ["84.182.697/0001-52", "70.666.463/0001-32", "98144683000151", "92938645000148"]
        Burocracia::CNPJ.valid?(invalids.sample).should be_false
      end
    end
  end

  describe "#formatted?" do
    context "when the input is formatted" do
      it "returns true" do
        Burocracia::CNPJ.formatted?("56.566.892/0001-47").should be_true
      end
    end

    context "when the input is formatted" do
      it "returns false" do
        Burocracia::CNPJ.formatted?("38617618000178").should be_false
      end
    end
  end

  describe "#format" do
    it "returns the formatted CNPJ" do
      Burocracia::CNPJ.format("18086319000147").should eq("18.086.319/0001-47")
    end

    context "when the CNPJ is already formatted" do
      it "returns the formatted CNPJ" do
        Burocracia::CNPJ.format("18.086.319/0001-47").should eq("18.086.319/0001-47")
      end
    end
  end

  describe "#generate" do
    context "when the format parameter is true" do
      it "generates a valid CNPJ" do
        generated = Burocracia::CNPJ.generate(format: true)
        Burocracia::CNPJ.valid?(generated).should be_true
      end

      it "generates a formatted CNPJ" do
        generated = Burocracia::CNPJ.generate(format: true)
        Burocracia::CNPJ.formatted?(generated).should be_true
      end
    end

    context "when the format parameter is false" do
      it "generates a valid CNPJ" do
        generated = Burocracia::CNPJ.generate
        Burocracia::CNPJ.valid?(generated).should be_true
      end

      it "generates a unformatted CNPJ" do
        generated = Burocracia::CNPJ.generate
        Burocracia::CNPJ.formatted?(generated).should be_false
      end
    end
  end

  describe "#sanitize" do
    it "clears the cpf" do
      Burocracia::CNPJ.sanitize("18.086.319/0001-47").should eq("18086319000147")
    end
  end
end

