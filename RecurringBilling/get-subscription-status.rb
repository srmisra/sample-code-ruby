require 'rubygems'
  require 'yaml'
  require 'authorizenet'

  include AuthorizeNet::API

  config = YAML.load_file(File.dirname(__FILE__) + "/../credentials.yml")
 transaction = Transaction.new(config['api_login_id'], config['api_transaction_key'], :gateway => :sandbox)
  #subscription = Subscription.new(config['api_login_id'], config['api_subscription_key'], :gateway => :sandbox)

    request = ARBGetSubscriptionStatusRequest.new
    request.refId = '2238251168'
    request.subscriptionId = '2790501'
    #request.subscription = ARBSubscriptionType.new
    #request.subscriptionId = 100748
    #request.subscription = ARBSubscriptionType.new
    

    response = transaction.get_subscription_status(request)
     
    #validate the transaction was created
    #expect(response.transactionResponse.transId).not_to eq("0")  
    #{request.customerProfileId}


if response != nil
  if response.messages.resultCode == MessageTypeEnum::Ok
    puts "Successfully got subscription status #{response.status}"

  else
    #puts response.transactionResponse.errors.errors[0].errorCode
    #puts response.transactionResponse.errors.errors[0].errorText
    puts response.messages.messages[0].code
    puts response.messages.messages[0].text
    raise "Failed to get a subscriptions status"
  end
end
