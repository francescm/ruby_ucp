#encoding: utf-8

require_relative '../../lib/ucp/base'
require_relative '../../lib/ucp/util/base'
require_relative '../../lib/ucp/util/ucp'

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
     expect(table['c']).to be_eql 'c'
     expect(table['A']).to be_eql 'A'
     expect(table['2']).to be_eql '2'
     expect(ext_table['€']).to be_eql 0x65
   end
   
   it "translets a ASCII string to GSM alphabet" do
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
 end
 
end
   