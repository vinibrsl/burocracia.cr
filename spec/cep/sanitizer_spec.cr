require "../spec_helper"

module Burocracia::CEP::Sanitizer
  extend self
end

describe Burocracia::CEP::Sanitizer do
  describe "#process" do
    it "removes all chars but numbers" do
      sanitized = Burocracia::CEP::Sanitizer.sanitize "a1b2b3b4b5"
      sanitized.should eq "12345"
    end

    it "selects the first eight numbers" do
      sanitized = Burocracia::CEP::Sanitizer.sanitize "123456789"
      sanitized.should eq "12345678"
    end

    it "process integers returning strings" do
      sanitized = Burocracia::CEP::Sanitizer.sanitize 80210130
      sanitized.should eq "80210130"
    end
  end
end
