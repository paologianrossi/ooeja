require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.build(:bookmark)).to be_valid
  end

  describe "url" do
    it "must be present" do
      expect(FactoryGirl.build(:bookmark, url: nil)).not_to be_valid
    end
    context "when it is an actual url" do
      it "is valid" do
        expect(FactoryGirl.build(:bookmark, url: "http://www.example.com/")).to be_valid
      end
    end

    context "when it is not a valid url" do
      it "is not valid" do
        expect(FactoryGirl.build(:bookmark, url: "http:/www.example,com/")).not_to be_valid
      end
    end

    context "when it is a schemeless url" do
      it "is valid" do
        expect(FactoryGirl.build(:bookmark, url: "www.example.com")).to be_valid
      end
    end
  end

  it "requires a user" do
    expect(FactoryGirl.build(:bookmark, user: nil)).not_to be_valid
  end

  describe "#to_s" do
    context "when a title is available" do
      it "is the title" do
        bookmark = FactoryGirl.build(:bookmark, title: "foobar")
        expect(bookmark.to_s).to eq "foobar"
      end
    end
    context "when the title is missing" do
      it "is the url" do
        bookmark = FactoryGirl.build(:bookmark, title: "")
        expect(bookmark.to_s).to eq bookmark.url
      end
    end
  end

  describe ".search" do
    before { @bookmarks = [FactoryGirl.create(:bookmark, title: "foo"), FactoryGirl.create(:bookmark, title: "bar"), FactoryGirl.create(:bookmark, title: "baz")] }
    context "when there is no search string" do
      it "returns all bookmarks" do
        expect(Bookmark.search(nil).to_a).to eq @bookmarks
      end
    end
  end
end
