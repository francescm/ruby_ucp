#encoding: utf-8

require_relative '../../lib/ucp/base'
require_relative '../../lib/ucp/pdu/base'
require_relative '../../lib/ucp/pdu/ucpmessage'

module Ucp::Pdu

 describe UCPMessage do
    before(:all) do
      @delimiter = UCPMessage.class_eval("DELIMITER")
    end
   
    it "initializes with no args" do
      u = UCPMessage.new
      expect u
    end
    
    it "calculates its checksum" do
      u = UCPMessage.new
      payload = "00/00104/O/52/3399913107/00393404679829/////////////301115142450////3//48616C6C6F20736D73/////////////"
      checksum = "42"
      expect(u.checksum(payload)).to be_eql checksum
    end
    
    it "prints to string" do
      u = UCPMessage.new
      u.instance_variable_set(:@operation, '60')
      u.instance_variable_set(:@operation_type, 'O')
      u.instance_variable_set(:@fields, [:oadc,:oton,:onpi,:styp,:pwd,:npwd,:vers,:ladc,:lton,:lnpi,:opid,:res1])
      # "\x0200/00028/O/60/////////////FF\x03"
      expect(u.to_s).to match(/60/)
    end
  end

end
