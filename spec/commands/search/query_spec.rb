RSpec.describe Search::Query do
  context "given an empty query" do
    let(:query) { described_class.new("", klass: nil) }

    it "has a nil tag" do
      expect(query.tag).to be_nil
    end

    it "has a '*' text" do
      expect(query.text).to eq "*"
    end
  end

  context "given a null query" do
    let(:query) { described_class.new(nil, klass: nil) }
    it "has a nil tag" do
      expect(query.tag).to be_nil
    end
    it "has a '*' text" do
      expect(query.text).to eq "*"
    end
  end

  context "given just a tag" do
    let(:query) { described_class.new("tag: sometag", klass: nil) }

    it "has that tag as a tag" do
      expect(query.tag).to eq "sometag"
    end
    it "has '*' as text" do
      expect(query.text).to eq "*"
    end
  end

  context "given a tag and a query" do
    let(:query) { described_class.new("tag: sometag some search", klass: nil) }
    it "has that tag as a tag" do
      expect(query.tag).to eq "sometag"
    end
    it "has the correct query as text" do
      expect(query.text).to eq "some search"
    end
  end

  context "query surrounding tag" do
    let(:query) { described_class.new("some tag: sometag search", klass: nil) }
    it "has that tag as a tag" do
      expect(query.tag).to eq "sometag"
    end
    it "has the correct query as text" do
      expect(query.text).to eq "some  search"
    end
  end

  context "with multiple word tag" do
    let(:query) { described_class.new('tag:"sometag search"', klass: nil) }
    it "has that tag as a tag" do
      expect(query.tag).to eq "sometag search"
    end
    it "has '*' as text" do
      expect(query.text).to eq "*"
    end

    context "and also a query" do
      let(:query) { described_class.new('foo tag:"sometag search" something', klass: nil) }
      it "has that tag as a tag" do
        expect(query.tag).to eq "sometag search"
      end
      it "has the right text" do
        expect(query.text).to eq "foo  something"
      end
    end
  end
end
