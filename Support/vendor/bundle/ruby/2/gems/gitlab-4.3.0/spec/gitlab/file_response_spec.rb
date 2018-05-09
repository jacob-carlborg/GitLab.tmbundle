require 'spec_helper'

describe Gitlab::FileResponse do
  before do
    @file_response = Gitlab::FileResponse.new StringIO.new("", 'rb+')
  end

  context '.empty?' do
    it "returns false" do
      expect(@file_response.empty?).to be false
    end
  end

  context '.to_hash' do
    it "has `filename` key and `data` key" do
      h = @file_response.to_hash
      expect(h.key?(:filename)).to be_truthy
      expect(h.key?(:data)).to be_truthy
    end
  end

  context '.parse_headers!' do
    it "parses headers" do
      @file_response.parse_headers!('Content-Disposition' => 'attachment; filename=artifacts.zip')
      expect(@file_response.filename).to eq "artifacts.zip"
    end

    it "handles quoted filenames" do
      @file_response.parse_headers!('Content-Disposition' => 'attachment; filename="artifacts.zip"')
      expect(@file_response.filename).to eq "artifacts.zip"
    end
  end
end
