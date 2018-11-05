require "../spec_helper"

describe Burocracia::CEP::Address do
  describe "#find" do
    context "when the cep exists" do
      it "returns an address" do
        address = Burocracia::CEP::Address.find "80210130", secure: false
        address.nil?.should be_false
        address.street.blank?.should be_false
      end
    end

    context "when a cep does not exist" do
      it "raises Burocracia::CEP::ApiRequestError" do
        expect_raises(Burocracia::CEP::ApiRequestError, /404/) do
          Burocracia::CEP::Address.find "123"
        end
      end
    end

    context "when an integer is passed" do
      it "returns an address" do
        address = Burocracia::CEP::Address.find 80210130
        address.nil?.should be_false
        address.street.blank?.should be_false
      end
    end
  end
end
