require 'paho-mqtt'

### Create a simple client with default attributes
client = PahoMqtt::Client.new

### Register a callback for puback event when the Broker acknowledges a publication
waiting_puback = true # A flag so we can wait for the acknowledgement
client.on_puback do
  waiting_puback = false
  puts "Message Acknowledged by Broker"
end

### Set the encryption mode to True
client.ssl = true
### Configure the user SSL key and the certificate
client.config_ssl_context('certs/JoshRuby.cert.pem', 'certs/JoshRuby.private.key','certs/AmazonRootCA1.pem')

### Connect to the test broker on port 1883 (Unencrypted mode)
client.connect('amn4qw1e16nzl-ats.iot.us-east-2.amazonaws.com', 8883)

topic = "/test/"
message = "Hello there!"
puts("Sending: \nTopic: #{topic}\nMessage: #{message}")

client.publish(topic, message, false, 1)

while waiting_puback do
    sleep(0.001)
end

### Call an explicit disconnect
client.disconnect




