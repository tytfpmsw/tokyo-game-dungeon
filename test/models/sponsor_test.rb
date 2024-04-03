require "test_helper"

class SponsorTest < ActiveSupport::TestCase
  test "should not save sponsor without name" do
    sponsor = Sponsor.new
    assert_not sponsor.save, "Saved the sponsor without a name"
  end

  test "should save sponsor with name" do
    sponsor = Sponsor.new(name: "test")
    assert sponsor.save, "Could not save the sponsor with a name"
  end

  test "should save sponsor with url" do
    sponsor = Sponsor.new(name: "test", url: "https://example.com")
    assert sponsor.save, "Could not save the sponsor with a url"
  end

  test "should not save sponsor with invalid url" do
    sponsor = Sponsor.new(name: "test", url: "example.com")
    assert_not sponsor.save, "Saved the sponsor with an invalid url"
  end
end
