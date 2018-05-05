require "./spec_helper"

module MyRandomifier
  extend self

  def rand(range : Range)
    1
  end
end

describe Burocracia::Generator do
  describe "#random_numbers" do
    context "when a size is passed" do
      it "generates a random sequence of numbers" do
        random_string = Burocracia::Generator.random_numbers(size: 5)
        random_string.size.should eq(5)
      end
    end

    context "when a randomifier instance is passed" do
      it "generates a sequence of numbers" do
        random_string = Burocracia::Generator.random_numbers(size: 3, randomifier: MyRandomifier)
        random_string.should eq("111")
      end
    end
  end
end
