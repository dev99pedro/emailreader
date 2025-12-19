require 'rails_helper'
RSpec.describe "Customer", type: :model do 



  describe "validate customer" do
    it "requires a telephone unless email is provided" do
      customer = build(:customer, email: nil)
      expect(customer).to be_valid
    end
    it "requires a email unless telephone is provided" do 
      customer = build(:customer, tel: nil)
      expect(customer).to be_valid
    end
    it "invalid if email and telephone is not provided" do 
      customer = build(:customer, tel: nil, email: nil)
      expect(customer).not_to be_valid
    end
  end

  describe "normalize fields" do 
    it "downcases the email before save" do
      customer = build(:customer, email: "Joao@Example.com")
      customer.save
      expect(customer.email).to eq("joao@example.com")
    end

    it "strips and normalizes spaces in name before save" do
      customer = build(:customer, name: "  João   da   Silva  ")
      customer.save
      expect(customer.name).to eq("João da Silva")
    end

    it "removes non-digit characters from tel before save" do
      customer = build(:customer, tel: "(11) 91234-5678")
      customer.save
      expect(customer.tel).to eq("11912345678")
    end
  end
  

end