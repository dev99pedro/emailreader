FactoryBot.define do
  factory :process_log do
    status { "pending" }
    filename { "email1.eml" }
    error { "Email somdomarx10@gmail.com não é um remetente" }
    extracteddata {
      {
        "name" => "João da Silva",
        "tel" => "(11) 91234-5678",
        "email" => "joao.silva@example.com",
        "code" => "ABC123"
      }
    }
  end
end