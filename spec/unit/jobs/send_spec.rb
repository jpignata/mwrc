require "spec_helper"

describe Jobs::Send do
  let(:server) { stub }
  let(:data) { ['SEND abc123 "Hello world"', stub] }
  let(:job) { Jobs::Send.new(data, server) }

  it "returns the JSON representation of the parameterized message" do
    json = {
      "registration_ids" => ["abc123"],
      "data" => {
        "alert" => "Hello world"
      }
    }.to_json

    job.run.should eq(json)
  end
end
