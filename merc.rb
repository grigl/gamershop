require "rubygems"
require "active_merchant"

ActiveMerchant::Billing::Base.mode = :test

gateway = ActiveMerchant::Billing::PaypalGateway.new(
  login:     "griglm_1332980966_biz_api1.gmail.com",
  password:  "1332981003",
  signature: "AiPC9BjkCyDFQXbSkoZcgqH3hpacAck9J23Cb7A7mLznM5pd7-wR3HkY"
)

credit_card = ActiveMerchant::Billing::CreditCard.new(
  type:               "visa",
  number:             "4024007148673576",
  verification_value: "123",
  month:              1,
  year:               "2013",
  first_name:         "Ryan",
  last_name:          "Bobikov"
)

if credit_card.valid?
  response = gateway.purchase(1000, credit_card, ip: '127.0.0.1')
  if response.success?
    puts "transaction complete!"
  else
    puts "Error: #{response.message}"
  end
else
  puts "card is not valid. #{credit_card.errors.full_messages.join('. ')}"
end