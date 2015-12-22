#encoding: utf-8

require_relative '../../lib/ucp/base'
require_relative '../../lib/ucp/pdu/base'
require_relative '../../lib/ucp/util/base'
require_relative '../../lib/ucp/util/ucp'
require_relative '../../lib/ucp/util/packed_msg'
require_relative '../../lib/ucp/util/gsm_packed_msg'

module Ucp::Util

 describe UCP do
   it "add a char to map" do
     UCP.add_char(0x00,"@")
     table = UCP.instance_variable_get("@gsmtable")
     expect(table['@']).to be_eql 0x00
   end
   
   it "builds the ascii2ira table mapping" do
     UCP.initialize_ascii2ira
     table = UCP.instance_variable_get("@gsmtable")
     ext_table = UCP.instance_variable_get("@extensiontable")
     expect(table['c']).to be_eql 'c'.bytes.first
     expect(table['A']).to be_eql 'A'.bytes.first
     expect(table['2']).to be_eql '2'.bytes.first
     expect(ext_table['€']).to be_eql 0x65
   end
   
   it "translates a ASCII string to GSM alphabet" do
     msg = "Hallo sms"
     #verify value got from ruby_ucp with ruby-1.8.7
     verify_value = "C8309BFD06CDDB73"     
     expect(UCP.pack7bits(msg)).to be_eql verify_value
   end
   
   it "translets a extended string to GSM alphabet" do
     msg = "Win 1000€"
     #verify value got from ruby_ucp with ruby-1.8.7
     verify_value = "D7B41B1483C1609B32"     
     expect(UCP.pack7bits(msg)).to be_eql verify_value
   end
   
   it "coverts int to hex (wide 2 nibbles)" do
     int = 60
     expect(UCP.int2hex(int)).to be_eql int.to_s(16).upcase 
   end
   
   it "converts a string to ira" do
     msg = "Olé 1€ sms"
     #packed_msg = GsmPackedMsg.new("", msg, 7, 7, false)
     packed_msg = UCP.ascii2ira(msg)
     expect(packed_msg.instance_variable_get("@encoded")).to be_eql "4F6C0520311B6520736D73"
   end
   
   it "decodes ira back to string" do
     #encoded = "6E6967657269616E207363616D"
     #decoded = "nigerian scam"
     encoded = "4F6C0520311B6520736D73"
     decoded = "Olé 1€ sms"
     expect(UCP.decode_ira(encoded)).to be_eql decoded
   end

   it "packs OAdC" do
     decoded = "ALPHA@NUM"
     encoded_hex = [0x10, 0x41, 0x26, 0x14, 0x19, 0x04, 0x38, 0xAB, 0x4D]
     encoded = encoded_hex.map{|hex| sprintf("%02X", hex)}.join
     expect(UCP.packoadc(decoded)).to be_eql encoded
   end
 end
 
end
   