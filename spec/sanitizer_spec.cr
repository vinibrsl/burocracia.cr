require "./spec_helper"

describe Burocracia::Sanitizer do
  describe "#sanitize" do
    it "removes symbols" do
      Burocracia::Sanitizer.sanitize("1.231.23-84").should eq("12312384")
    end

    it "removes letters" do
      Burocracia::Sanitizer.sanitize("a1b2b3").should eq("123")
    end

    it "removes spaces" do
      Burocracia::Sanitizer.sanitize("12 3129 38 1").should eq("123129381")
    end

    it "trims" do
      Burocracia::Sanitizer.sanitize("12398 ").should eq("12398")
    end
  end
end
