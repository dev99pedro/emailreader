RSpec.describe "Process", type: :model do 

  describe "validate status" do 
    it "is valid for pending, completed, failed" do
      %w[pending completed failed].each do |valid_status|
        process_log = build(:process_log, status: valid_status)
        expect(process_log).to be_valid
      end
    end

    it "it should be invalid if is not peding , completed, failed" do 
      process_log = build(:process_log, status: "loading")
      expect(process_log).not_to be_valid
      expect(process_log.errors[:status]).to include("is not included in the list")
    end
  end
end