RSpec.describe Search do
  describe Search::Query do
    context "given an empty query" do
      it "has a nil tag" do
        query = described_class.new("")
        expect(query.tag).to be_nil
      end
      it "has a '*' text" do
        query = described_class.new("")
        expect(query.text).to eq "*"
      end
    end

    context "given a null query" do
      it "has a nil tag" do
        query = described_class.new(nil)
        expect(query.tag).to be_nil
      end
      it "has a '*' text" do
        query = described_class.new(nil)
        expect(query.text).to eq "*"
      end
    end

    context "given just a tag" do
      it "has that tag as a tag" do
        query = described_class.new("tag: sometag")
        expect(query.tag).to eq "sometag"
      end
      it "has '*' as text" do
        query = described_class.new("tag: sometag")
        expect(query.text).to eq "*"
      end
    end

    context "given a tag and a query" do
      it "has that tag as a tag" do
        query = described_class.new("tag: sometag some search")
        expect(query.tag).to eq "sometag"
      end
      it "has the correct query as text" do
        query = described_class.new("tag: sometag some search")
        expect(query.text).to eq "some search"
      end
    end

    context "query surrounding tag" do
      it "has that tag as a tag" do
        query = described_class.new("some tag: sometag search")
        expect(query.tag).to eq "sometag"
      end
      it "has the correct query as text" do
        query = described_class.new(" some tag: sometag search")
        expect(query.text).to eq "some  search"
      end
    end

    context "with multiple word tag" do
      it "has that tag as a tag" do
        query = described_class.new('tag:"sometag search"')
        expect(query.tag).to eq "sometag search"
      end
      it "has '*' as text" do
        query = described_class.new('tag:"sometag search"')
        expect(query.text).to eq "*"
      end
      context "and also a query" do
        it "has that tag as a tag" do
          query = described_class.new('foo tag:"sometag search" something')
          expect(query.tag).to eq "sometag search"
        end
        it "has the right text" do
          query = described_class.new('foo tag:"sometag search" something')
          expect(query.text).to eq "foo  something"
        end
      end
    end
  end
end
