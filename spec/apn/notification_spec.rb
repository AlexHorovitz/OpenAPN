require File.dirname(__FILE__) + '/../spec_helper'

describe OpenAPN::Notify do
  
  it "should take a string as the message" do
    n = OpenAPN::Notify.new('device_token', 'Hello')
    n.alert.should == 'Hello'
  end
  
  it "should take a hash as the message" do
    n = OpenAPN::Notify.new('device_token', {:alert => 'Hello iPhone', :badge => 3})
    n.alert.should == "Hello iPhone"
    n.badge.should == 3
  end
  
  describe '#packaged_message' do
    
    it "should return JSON with notification information" do
      n = OpenAPN::Notify.new('device_token', {:alert => 'Test Apple Push Notification', :badge => 3, :sound => 'basso.caf'})
      n.payload_message.should  == "{\"aps\":{\"alert\":\"Test Apple Push Notification\",\"badge\":3,\"sound\":\"basso.caf\"}}"
    end
    
    it "should not include keys that are empty in the JSON" do
      n = OpenAPN::Notify.new('device_token', {:badge => 3})
      n.payload_message.should == "{\"aps\":{\"badge\":3}}"
    end
    
  end
  
  describe '#package_token' do
    it "should package the token" do
      n = OpenAPN::Notify.new('<4442c326 7ede5aec becb6881 1b5f0020 c0601a32 03c06be4 55d874a2 7cec12db>', 'a')
      $stdout.print n.payload_token
      Base64.encode64(n.payload_token).should == "RELDJn7eWuy+y2iBG18AIMBgGjIDwGvkVdh0onzsEts=\n"
    end
  end

  describe '#packaged_notification' do
    it "should package the token" do
      n = OpenAPN::Notify.new('device_token', {:alert => 'Test Apple Push Notification', :badge => 3, :sound => 'basso.caf'})
      Base64.encode64(n.notification_payload).should == "AAAg3vLO/YTnAE57ImFwcyI6eyJhbGVydCI6IlRlc3QgQXBwbGUgUHVzaCBO\nb3RpZmljYXRpb24iLCJiYWRnZSI6Mywic291bmQiOiJiYXNzby5jYWYifX0=\n"
    end
  end
  
end
